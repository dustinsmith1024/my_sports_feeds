defmodule MySportsFeeds.Entities.TeamStats do
  alias MySportsFeeds.Entities.Stats
  alias MySportsFeeds.Entities.Team

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    team: %Team{},
    stats: %Stats{},
  ]
end
