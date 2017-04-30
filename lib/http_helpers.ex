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
        default_headers = %{
            "Content-Type": "application/json",
            # TODO: Pull from config
            "Authorization": "Basic ZHVzdGluc21pdGgxMDI0OkR1JHRpbjEwMjQ="
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
     case response.status_code do
      304 ->
        Logger.info "No new info found"
        {:ok, false}
      200 ->
        # TODO: Make a formatted response handler here.
        # Can make an option to pass back 'raw' if wanted
        Logger.info "Got results...parsing"
        parse(response)
      other ->
        Logger.debug(response.headers)
        {:error, other}
    end
  end
end
