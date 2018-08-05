defmodule MySportsFeeds.Entities.Playbyplay do
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.Game
  alias MySportsFeeds.Entities.Games.ScoringAlert
  alias MySportsFeeds.Entities.NFL.Play

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    game: %Schedule{},
    plays: [%Play{}],
  ]

  # away-home
  def game_score(score) do
    "#{score.awayScore}-#{score.homeScore}"
  end

  def boxscore_alerts(%MySportsFeeds.Entities.Boxscore{game: game, scoring: score}) do
    Enum.flat_map(score.quarters, fn(quarter) ->
      Enum.map(quarter.scoringPlays, fn(play) ->
        game_name = Schedule.game_name(game)
        game_score = game_score(play)
        %ScoringAlert{
          quarterNumber: quarter.quarterNumber,
          quarterSecondsElapsed: play.quarterSecondsElapsed,
          teamAbbr: play.team.abbreviation,
          scoreChange: play.scoreChange,
          awayScore: play.awayScore,
          homeScore: play.homeScore,
          playDescription: "#{game_name} #{game_score} #{play.playDescription}",
        }
      end)
    end)
  end
end
