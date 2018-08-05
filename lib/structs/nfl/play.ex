defmodule MySportsFeeds.Entities.NFL.Play do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.NFL.Kick
  alias MySportsFeeds.Entities.NFL.Pass
  alias MySportsFeeds.Entities.NFL.Position

  @derive [Poison.Encoder]
  defstruct [
      quarter: nil, # 1,
      secondsElapsed: nil, # 0,
      currentDown: nil, # 0,
      yardsRemaining: nil, # 0,
      lineOfScrimmage: %Position{},
      description: nil, # "S.Gostkowski kicks 64 yards from NE 35 to PHI 1. C.Clement pushed ob at PHI 26 for 25 yards (P.Chung).",
      kick: %Kick{},
      pass: %Pass{},
      quarterSecondsElapsed: nil, # 168,
      team: %Team{}, #
      scoreChange: nil, # 6,
      awayScore: nil, # 0,
      homeScore: nil, # 6,
      playDescription: nil, # "M.Gillislee up the middle for 2 yards, TOUCHDOWN."
  ]

end
