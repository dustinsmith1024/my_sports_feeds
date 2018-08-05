defmodule MySportsFeeds.Entities.TeamLineup do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.LineupPositions

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    team: %Team{},
    expected: %LineupPositions{},
    actual: %LineupPositions{},
  ]
end
