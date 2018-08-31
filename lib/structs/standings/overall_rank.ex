defmodule MySportsFeeds.Entities.Standings.OverallRank do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    rank: nil, #18,
    gamesBack: nil, #5
  ]
end
