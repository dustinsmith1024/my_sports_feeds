defmodule MySportsFeeds.Entities.Games.Score do
  alias MySportsFeeds.Entities.Games.Quarter

  @derive [Poison.Encoder]
  defstruct [
    currentQuarter: nil, # null,
    currentQuarterSecondsRemaining: nil, # null,
    currentIntermission: nil, # null,
    teamInPossession: nil, # null,
    currentDown: nil, # null,
    currentYardsRemaining: nil, # null,
    lineOfScrimmage: nil, # null,
    awayScoreTotal: nil, # null,
    homeScoreTotal: nil, # null,
    quarters: [%Quarter{}], # []
  ]

end