defmodule MySportsFeeds.Entities.TeamStatsTotals do
  alias MySportsFeeds.Entities.TeamStats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    teamStatsTotals: [%TeamStats{}],
  ]
end
