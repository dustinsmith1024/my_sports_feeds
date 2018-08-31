defmodule MySportsFeeds.Entities.ForGame do
  alias MySportsFeeds.Entities.Games.Schedule

  @derive [Poison.Encoder]
  defstruct [
    game: %Schedule{},
    lastUpdatedOn: nil,
  ]
end
