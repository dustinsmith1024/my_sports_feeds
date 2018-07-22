defmodule MySportsFeeds.Entities.SeasonalPlayerStatsRepsonse do
  alias MySportsFeeds.Entities.SeasonalPlayerStats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    seasonalPlayerStats: %SeasonalPlayerStats{},
  ]
end
