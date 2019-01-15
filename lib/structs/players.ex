defmodule MySportsFeeds.Entities.Players do
  alias MySportsFeeds.Entities.PlayerTeam

  @derive [Poison.Encoder]
  defstruct [
    lastUpdatedOn: nil,
    players: [%PlayerTeam{}],
  ]
end
