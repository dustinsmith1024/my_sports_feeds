defmodule MySportsFeeds.Entities.Injuries do
  alias MySportsFeeds.Entities.Player

  @derive [Poison.Encoder]
  defstruct [
    lastUpdatedOn: nil,
    players: [%Player{}],
  ]
end
