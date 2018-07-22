defmodule MySportsFeeds.Entities.Boxscore do
  # alias MySportsFeeds.Entities.Game
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.Games.Score

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    game: %Schedule{},
    scoring: %Score{},
  ]
end
