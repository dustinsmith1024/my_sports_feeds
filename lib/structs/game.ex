defmodule MySportsFeeds.Entities.Game do
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.Games.Score

  @derive [Poison.Encoder]
  defstruct [
    schedule: %Schedule{},
    score: %Score{},
  ]

end
