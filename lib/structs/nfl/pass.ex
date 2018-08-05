defmodule MySportsFeeds.Entities.NFL.Pass do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.NFL.Position

  @derive [Poison.Encoder]
  defstruct [
    assistedTacklingPlayer1: %Player{},
    assistedTacklingPlayer2: %Player{},
    blockingPlayer: %Player{}, # null,
    interceptedAtPosition: %Position{},
    interceptingPlayer: %Player{},
    isBlocked: nil, # false,
    isCompleted: nil, # true,
    isEndedWithTouchdown: nil, # false,
    isFairCatch: nil, # false,
    isFirstDownPenalty: nil, # false,
    isLanded: nil, # false,
    isNoPlay: nil, # false,
    isOnside: nil, # false,
    isOutOfBounds: nil, # true,
    isSafety: nil, # false,
    isTackled: nil, # false,
    isTouchback: nil, # false,
    isTouchdown: nil, # false,
    isTwoPointConversion: nil, # false,
    kickedFromPosition: %Position{},
    kickingPlayer: %Player{},
    kickingTeam: %Team{},
    passedFromPosition: %Position{}, # null,
    passingPlayer: %Player{},
    penalties: nil, # []
    receivedAtPosition: %Position{},
    receivingPlayer: %Player{},
    retrievedAtPosition: %Position{},
    retrievingPlayer: %Player{},
    retrievingTeam: %Team{},
    soloTacklingPlayer: %Player{},
    stoppedAtPosition: %Position{},
    subPlays: nil, # [],
    team: %Team{},
    totalYardsGained: nil, # 4,
    yardsIntercepted: nil, # 0,
    yardsKicked: nil, # 64,
    yardsPassed: nil, # 5,
    yardsReturned: nil, # 25,
    yardsRushed: nil, # -1,
  ]

end
