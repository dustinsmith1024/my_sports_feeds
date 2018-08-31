defmodule MySportsFeeds.Entities.Standings.ConferenceRank do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    conferenceName: nil, #"NFC",
    rank: nil, #10,
    gamesBack: nil, #5
  ]
end
