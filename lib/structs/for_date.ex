defmodule MySportsFeeds.Entities.ForDate do
  # alias MySportsFeeds.Entities.Game

  @derive [Poison.Encoder]
  defstruct [
    forDate: nil,
    lastUpdatedOn: nil,
  ]
end
