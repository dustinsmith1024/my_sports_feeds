defmodule MySportsFeeds.Entities.LineupPosition do
  alias MySportsFeeds.Entities.Player

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    position: nil, #"Offense-RB-1",
    player: %Player{},
  ]
end
