defmodule MySportsFeeds.Entities.TeamStanding do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats
  alias MySportsFeeds.Entities.Standings.OverallRank
  alias MySportsFeeds.Entities.Standings.ConferenceRank
  alias MySportsFeeds.Entities.Standings.DivisionRank
  alias MySportsFeeds.Entities.Standings.PlayoffRank


  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    team: %Team{},
    stats: %Stats{},
    overallRank: %OverallRank{},
    conferenceRank: %ConferenceRank{},
    divisionRank: %DivisionRank{},
    playoffRank: %PlayoffRank{},
  ]
end
