defmodule MySportsFeeds.Request do
  require Logger

    def parse(response) do
        Poison.decode(response.body)
    end

    def headers() do
        default_headers = %{
            "Content-Type": "application/json",
            "Authorization": "Basic ZHVzdGluc21pdGgxMDI0OkR1JHRpbjEwMjQ="
        }
    end

    def get(url) do
        Logger.info "Go for URL: #{url}"
        # HTTPoison.start
        # TODO: Move standard parsing logic and error handling here
        HTTPoison.get!(url, headers(), timeout: 600000, recv_timeout: 60000)
    end
end
