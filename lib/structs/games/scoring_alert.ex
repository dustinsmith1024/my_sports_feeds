defmodule MySportsFeeds.Entities.Games.ScoringAlert do
  alias MySportsFeeds.Entities.Team

  @derive [Poison.Encoder]
  defstruct [
    quarterSecondsElapsed: nil, # 168,
    teamAbbr: nil, #
    scoreChange: nil, # 6,
    awayScore: nil, # 0,
    homeScore: nil, # 6,
    playDescription: nil, # "M.Gillislee up the middle for 2 yards, TOUCHDOWN."
    quarterNumber: nil, # I added this its not default
  ]

end
