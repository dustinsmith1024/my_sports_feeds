defmodule MySportsFeeds.Request do
  require Logger

  @moduledoc """
    Request handling and basic caching for http requests.
  """

  @doc """
    cached_get: does a get and stores it in the cache.
    If the URL contains 'force=true' then the cache is skipped,
    **but the cache is still populated**.
    You can specify a ttl in seconds for each request.
  """
  def cached_get(url, ttl_seconds \\ 60) do
    cached_val = if String.contains?(url, "force=true") do
        {:false, nil}
    else
        # {:ok, something or nil}
        Cachex.get(:app_cache, clean_cache_key(url))
    end

    case cached_val do
        {:ok, v} when is_nil(v) == false -> v # Use cache
        {_, _} -> # {:error/:missing/:false, nil}
            force_url = String.replace(url, "force=false", "force=true")
            res = get(force_url)

            cache(url, res, ttl_seconds)

            res
    end
  end

  defp clean_cache_key(url) do
    url
    |> String.replace("force=true", "")
    |> String.replace("force=false", "")
  end

  def cache(key, val, ttl_seconds) do
      Task.async(fn ->
        key = clean_cache_key(key)
        Cachex.set(:app_cache, key, val, ttl: :timer.seconds(ttl_seconds))
      end)
  end

  def parse(response) do
    Poison.decode(response.body)
  end

  def headers do
    %{
      "Content-Type": "application/json",
      "Authorization": "Basic " <> Application.get_env(:my_sports_feeds, :token)
    }
  end

  def get(url) do
    url |> raw_get |> handle
  end

  def raw_get(url) do
    Logger.info fn -> "Go for URL: #{url}" end
    HTTPoison.get!(url, headers(), timeout: 600_000, recv_timeout: 60_000)
  end

  def handle(response) do
    # TODO: Put in a timer log message
    case response.status_code do
    304 ->
      Logger.info "No new info found"
      {:ok, false}
    200 ->
      # TODO: Make a formatted response handler here.
      # Can make an option to pass back 'raw' if wanted
      Logger.info "Got results...parsing"
      parse(response)
    404 ->
      Logger.info "Route not found, check query params"
      {:error, "Not found"}
    other ->
      Logger.debug "#{inspect response}"
      {:error, other}
    end
  end

  def cached_keys do
    {_, keys} = Cachex.keys(:app_cache)

    Enum.map(keys, fn(key) ->
      {_, ttl} = Cachex.ttl(:app_cache, key)
      {key, ttl}
    end)
  end
end
