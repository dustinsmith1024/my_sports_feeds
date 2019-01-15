defmodule MySportsFeeds.Entities.Standings.PlayoffRank do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    conferenceName: nil, #"NFC",
    divisionName: nil, #null,
    appliesTo: nil, #"CONFERENCE",
    rank: nil, #10
  ]
end
