defmodule MySportsFeeds.Entities.Stats do
  alias MySportsFeeds.Entities.Stats.Batting
  alias MySportsFeeds.Entities.Stats.Pitching
  alias MySportsFeeds.Entities.Stats.Fielding
  alias MySportsFeeds.Entities.Stats.Passing
  alias MySportsFeeds.Entities.Stats.Rushing
  alias MySportsFeeds.Entities.Stats.Receiving
  alias MySportsFeeds.Entities.Stats.Tackles
  alias MySportsFeeds.Entities.Stats.Interceptions
  alias MySportsFeeds.Entities.Stats.Fumbles
  alias MySportsFeeds.Entities.Stats.KickoffReturns
  alias MySportsFeeds.Entities.Stats.PuntReturns
  alias MySportsFeeds.Entities.Stats.TwoPointAttempts
  alias MySportsFeeds.Entities.Stats.Miscellaneous
  alias MySportsFeeds.Entities.Stats.Standings
  alias MySportsFeeds.Entities.Stats.FieldGoals
  alias MySportsFeeds.Entities.Stats.Punting
  alias MySportsFeeds.Entities.Stats.ExtraPointAttempt
  alias MySportsFeeds.Entities.Stats.Kickoffs

  @derive [Poison.Encoder]
  defstruct [
    gamesPlayed: nil, # 2,
    # MLB
    batting: %Batting{}, #
    pitching: %Pitching{}, # {
    fielding: %Fielding{}, #
    # NFL
    passing: %Passing{}, #
    standings: %Standings{},
    fieldGoals: %FieldGoals{},
    extraPointAttempt: %ExtraPointAttempt{},
    kickoffs: %Kickoffs{},
    punting: %Punting{},
    rushing: %Rushing{}, #
    receiving: %Receiving{}, #
    tackles: %Tackles{}, #
    interceptions: %Interceptions{}, #
    fumbles: %Fumbles{}, #
    kickoffReturns: %KickoffReturns{}, #
    puntReturns: %PuntReturns{}, #
    twoPointAttempts: %TwoPointAttempts{}, #
    # NBA??
    # NHL??
    miscellaneous: %Miscellaneous{},
  ]
end
