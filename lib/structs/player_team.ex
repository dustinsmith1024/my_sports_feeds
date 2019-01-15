defmodule MySportsFeeds.Entities.PlayerTeam do
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.Team

  @derive [Poison.Encoder]
  defstruct [
    teamAsOfDate: %Team{},
    player: %Player{},
  ]
end
