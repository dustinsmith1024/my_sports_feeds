defmodule MySportsFeeds.Entities.Standings.DivisionRank do

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    divisionName: nil, #"NFC West",
    rank: nil, #3,
    gamesBack: nil, #3
  ]
end
