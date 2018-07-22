defmodule MySportsFeeds.Entities.SeasonalPlayerStats do
  alias MySportsFeeds.Entities.PlayerStats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    playerStatsTotals: [%PlayerStats{}]
  ]
end
