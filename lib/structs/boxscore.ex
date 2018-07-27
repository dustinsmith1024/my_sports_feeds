defmodule MySportsFeeds.Entities.Boxscore do
  # alias MySportsFeeds.Entities.Game
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

  # away/home
  def game_score(score) do
    "#{score.awayScore}-#{score.homeScore}"
  end

  def boxscore_alerts(%MySportsFeeds.Entities.Boxscore{game: game, scoring: score}) do
    plays = Enum.flat_map(score.quarters, fn(quarter) ->
      Enum.map(quarter.scoringPlays, fn(play) ->
        # IO.inspect play
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

    plays
  end
  # {:ok, s} = Poison.decode(json_example, as: %Boxscore{})

  #   %{game: game, scoring: score} = s
  #   assert(game.id == 43306 )
  #   assert(game.week == 1)
  #   assert(game.venueAllegiance == "NEUTRAL")
  #   assert(game.scheduleStatus == "NORMAL")
  #   assert(game.originalStartTime == nil)
  #   assert(game.delayedOrPostponedReason == nil)
  #   assert(game.playedStatus == "COMPLETED")
  #   assert(game.awayTeam.abbreviation == "KC")
  #   assert(game.homeTeam.abbreviation == "NE")
  #   assert(game.venue.name == "Gillette Stadium")
  #   assert(score.awayScoreTotal == 42)
  #   assert(score.homeScoreTotal == 27)
  #   [q1, _, _, q4] = score.quarters
  #   assert(q1.quarterNumber == 1)
  #   assert(q1.awayScore == 7)
  #   assert(q1.homeScore == 7)
  #   assert(q4.quarterNumber == 4)
  #   [play | _ ] = q4.scoringPlays
  #   assert(play.playDescription == "(14:19) (Shotgun) A.Smith pass deep right to K.Hunt for 78 yards, TOUCHDOWN.")
end
