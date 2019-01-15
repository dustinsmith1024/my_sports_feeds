defmodule MySportsFeeds.Entities.Game do
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.Games.Score

  @derive [Poison.Encoder]
  defstruct [
    schedule: %Schedule{},
    score: %Score{},
  ]

  # (game date as YYYYMMDD) + "-" +
  # (away team abbreviation) + "-" +
  # (home team abbreviation)
  def id(%__MODULE__{} = game) do
    # IO.inspect(game)
    date = String.split(game.schedule.startTime, "T")
    |> hd
    |> String.replace("-", "")

    awayTeam = game.schedule.awayTeam.abbreviation
    homeTeam = game.schedule.homeTeam.abbreviation

    "#{date}-#{awayTeam}-#{homeTeam}"
  end

  def score(%__MODULE__{} = game) do
    awayTeam = game.schedule.awayTeam.abbreviation
    homeTeam = game.schedule.homeTeam.abbreviation
    awayTeamScore = game.score.awayScoreTotal
    homeTeamScore = game.score.homeScoreTotal
    "#{awayTeam} #{awayTeamScore}-#{homeTeam} #{homeTeamScore}"
  end

  #  %MySportsFeeds.Entities.Game{
  #     schedule: %MySportsFeeds.Entities.Games.Schedule{
  #       awayTeam: %MySportsFeeds.Entities.Team{
  #         abbreviation: "PHI",
  #         city: nil,
  #         homeVenue: nil,
  #         id: 54,
  #         name: nil
  #       },
  #       delayedOrPostponedReason: nil,
  #       homeTeam: %MySportsFeeds.Entities.Team{
  #         abbreviation: "NE",
  #         city: nil,
  #         homeVenue: nil,
  #         id: 50,
  #         name: nil
  #       },
  #       id: 43426,
  #       originalStartTime: nil,
  #       playedStatus: "COMPLETED",
  #       scheduleStatus: "NORMAL",
  #       startTime: "2018-02-04T23:30:00.000Z",
  #       venue: %MySportsFeeds.Entities.Venue{id: 61, name: "Gillette Stadium"},
  #       venueAllegiance: "NEUTRAL",
  #       week: 22
  #     },
end
