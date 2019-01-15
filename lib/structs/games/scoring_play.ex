defmodule MySportsFeeds.Entities.Games.ScoringPlay do
  alias MySportsFeeds.Entities.Team

  @derive [Poison.Encoder]
  defstruct [
    quarterSecondsElapsed: nil, # 168,
    team: %Team{}, #
    scoreChange: nil, # 6,
    awayScore: nil, # 0,
    homeScore: nil, # 6,
    playDescription: nil, # "M.Gillislee up the middle for 2 yards, TOUCHDOWN."
  ]

end
