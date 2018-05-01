defmodule MySportsFeeds.BaseRequest do

  def process_url(url) do
    IO.inspect url
    url
  end

  # This isn't really working updating anything
  def process_request_headers(headers) do
    [
      "Content-Type": "application/json",
      "Authorization": "Basic " <> Application.get_env(:my_sports_feeds, :token)
    ] ++ headers
  end

  def process_request_options(options) do
    Keyword.put(options, :timeout, 600_000)
    |> Keyword.put(:recv_timeout, 60_000)
  end

  def cache_or_req(url, funk, ttl_seconds) do
    case Cachex.get(:app_cache, url) do
      {:ok, v} when is_nil(v) == false -> v # Use cache
      {_, _} -> # {:error/:missing/:false, nil}
        res = funk.(url)
        cache(url, res, ttl_seconds)

        res
    end
  end

  def cache(key, val, ttl_seconds) do
    Task.async(fn ->
      Cachex.set(:app_cache, key, val, ttl: :timer.seconds(ttl_seconds))
    end)
  end
end