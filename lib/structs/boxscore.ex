defmodule MySportsFeeds.Entities.Boxscore do
  alias MySportsFeeds.Entities.Games.Schedule
  alias MySportsFeeds.Entities.Games.Score
  alias MySportsFeeds.Entities.Games.ScoringAlert

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    game: %Schedule{},
    scoring: %Score{},
  ]

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

  # away-home
  defp game_score(score) do
    "#{score.awayScore}-#{score.homeScore}"
  end

end
