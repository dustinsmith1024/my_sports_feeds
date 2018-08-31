defmodule MySportsFeeds.Entities.TeamStandings do
  alias MySportsFeeds.Entities.TeamStanding

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    teams: [%TeamStanding{}],
  ]
end
