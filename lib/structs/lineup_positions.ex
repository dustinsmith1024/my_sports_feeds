defmodule MySportsFeeds.Entities.LineupPositions do
  alias MySportsFeeds.Entities.LineupPosition

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lineupPositions: [%LineupPosition{}],
  ]
end
