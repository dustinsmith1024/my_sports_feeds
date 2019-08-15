defmodule MSF do
  @moduledoc """
  My Sports Feeds client

  iex(8)> r = MSF.NFL.weekly_odds_gamelines([date: "5", season: "2018-2019-playoffs"])
  iex(8)> {:ok, %{body: b}} = r
  iex(11)> {:ok, %{status: s}} = r
  """

  def get(path, opts \\ []) when is_list(opts) do
    opts
    |> api_key()
    |> client()
    |> Tesla.get(path, Keyword.take(opts, [:query]))
    |> parse_response()
  end

  defp parse_response({:ok, %{body: body, headers: headers, status: status}}) do
    case status do
      200 -> {:ok, %{body: body, headers: headers, status: status}}
      # 500, 400, 404 are common
      _ -> {:error, %{body: body, headers: headers, status: status}}
    end
  end

  defp parse_response({:error, error}) do
    {:error, %{error: error, body: "Something went wrong in the client."}}
  end

  def client(token) when token != nil do
    middleware = [
      Tesla.Middleware.Logger,
      {Tesla.Middleware.BaseUrl, "https://api.mysportsfeeds.com/v2.1/pull"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Basic " <> token}]}
    ]

    Tesla.client(middleware)
  end


  defp api_key(opts) do
    api_key = Keyword.get(opts[:query], :api_key)
      || Keyword.get(opts, :api_key) # this option probably wont be used
      || config_key()

    unless api_key do
      raise RuntimeError, """
      No API key found for My Sports Feeds.
      Pass `api_key` in with the options or set it in config

      MSF.NBA.games(api_key: "API_KEY")

      config :msf,
        api_key: "your_token"

      config :msf,
        api_key: {:system, "MY_SPORTS_FEEDS_API_KEY"}
      """
    end

    api_key
  end

  defp config_key do
    case Application.get_env(:msf, :api_key) do
      # Grabs the name you configured out of ENV
      {:system, env_key} ->
        # IO.puts("hi?", env_key)
        case System.get_env(env_key) do
          nil -> raise RuntimeError, "ENV Variable not set correctly"
          "" -> raise RuntimeError, "ENV Variable not set correctly"
          k -> k # the real key
        end
      nil -> System.get_env("MY_SPORTS_FEEDS_API_KEY")
      key -> key
    end
  end

end
