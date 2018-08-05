defmodule MySportsFeeds.Entities.NFL.Kick do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.NFL.Position

  @derive [Poison.Encoder]
  defstruct [
    kickingTeam: %Team{},
    kickingPlayer: %Player{},
    kickedFromPosition: %Position{},
    blockingPlayer: %Player{}, # null,
    retrievingTeam: %Team{},
    retrievingPlayer: %Player{},
    retrievedAtPosition: %Position{},
    soloTacklingPlayer: %Player{},
    assistedTacklingPlayer1: %Player{}, # null,
    assistedTacklingPlayer2: %Player{}, # null,
    stoppedAtPosition: %Position{},
    isBlocked: nil, # false,
    isTouchback: nil, # false,
    isSafety: nil, # false,
    isOutOfBounds: nil, # true,
    isTouchdown: nil, # false,
    isFairCatch: nil, # false,
    isLanded: nil, # false,
    isOnside: nil, # false,
    isFirstDownPenalty: nil, # false,
    isNoPlay: nil, # false,
    yardsKicked: nil, # 64,
    yardsReturned: nil, # 25,
    subPlays: nil, # [],
    penalties: nil, # []
  ]

end
