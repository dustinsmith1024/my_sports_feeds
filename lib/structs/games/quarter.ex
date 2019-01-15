defmodule MySportsFeeds.Entities.Games.Quarter do
  alias MySportsFeeds.Entities.Games.ScoringPlay

  @derive [Poison.Encoder]
  defstruct [
    quarterNumber: nil, # null,
    awayScore: nil, # null,
    homeScore: nil, # null,
    scoringPlays: [%ScoringPlay{}]
  ]

end