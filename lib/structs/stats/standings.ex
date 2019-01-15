defmodule MySportsFeeds.Entities.Stats.Standings do
  defstruct [
    Wins: nil, #10,
    Losses: nil, #6,
    ties: nil, #0,
    OTWins: nil, #0,
    OTLosses: nil, #1,
    WinPct: nil, #0.625,
    pointsFor: nil, #409,
    pointsAgainst: nil, #337,
    pointDifferential: nil, #72
  ]
end
