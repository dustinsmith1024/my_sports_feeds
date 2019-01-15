defmodule MySportsFeeds.Entities.Feed do
  # "name": "Seasonal Games",
  # "version": "v2_0",
  # "abbreviation": "SEASONAL_GAMES",
  # "description": "All games for a season including schedule, status and scores."
  @derive [Poison.Encoder]
  defstruct [
    name: nil,
    version: nil,
    abbreviation: nil,
    description: nil,
  ]
end
