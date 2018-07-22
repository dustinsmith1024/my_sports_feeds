defmodule MySportsFeeds.Entities.PlayerStats do
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    player: %Player{},
    team: %Team{},
    stats: %Stats{},
  ]
end
