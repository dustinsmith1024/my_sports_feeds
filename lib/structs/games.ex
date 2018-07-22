defmodule MySportsFeeds.Entities.Games do
  alias MySportsFeeds.Entities.Game

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    games: [%Game{}]
  ]
end
