defmodule MySportsFeeds.Entities.CurrentSeason do
  alias MySportsFeeds.Entities.Season

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    seasons: [%Season{}],
  ]
end
