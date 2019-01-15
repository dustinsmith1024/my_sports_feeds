defmodule MySportsFeeds.Entities.Lineup do
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.TeamLineup

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    game: %Schedule{},
    teamLineups: [%TeamLineup{}],
  ]
end
