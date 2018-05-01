defmodule MySportsFeeds.RosterPlayers do
  @moduledoc """
  Roster Players fetches the players on active rosters.
  """
  use HTTPoison.Base
  alias MySportsFeeds.BaseRequest
  alias MySportsFeeds.NFL.Player
  alias MySportsFeeds.NFL.Team
  alias MySportsFeeds.RosterPlayers

  # THIS IS ALL WIERD
  # HOW DO WE HANDLE ERRORS IN THESE?
  #


  # Use this to pass to the cache function
  # Pull out just the players
  def go(url) do
    RosterPlayers
          .get!(url)
          .body["rosterplayers"]["playerentry"]
  end



  # Cached version
  def fetch(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/roster_players.json?#{query_params}"
    |> BaseRequest.cache_or_req(&RosterPlayers.go/1, ttl_seconds)
  end

  def process_response_body("") do
    IO.warn "MySportsFeed response was probably cached."
    ""
  end

  # map this to drop the frivilous stuff?
  def process_response_body(body) do
    Poison.decode!(body, as: %{
      "rosterplayers" => %{
        "lastUpdatedOn" => "",
        "playerentry" => [
          %{
            "player" => %Player{},
            "team" => %Team{},
          }],
      }
    })
  end

  defp process_request_headers(headers) do
    BaseRequest.process_request_headers(headers)
  end

  defp process_request_options(options) do
    BaseRequest.process_request_options(options)
  end
end