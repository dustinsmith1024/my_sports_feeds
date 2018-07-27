defmodule MySportsFeedsTest do
  use ExUnit.Case
  doctest MySportsFeeds
  alias MySportsFeeds.Entities.SeasonalPlayerStatsRepsonse
  alias MySportsFeeds.Entities.SeasonalPlayerStats
  alias MySportsFeeds.Entities.PlayerStats
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.Games
  alias MySportsFeeds.Entities.Boxscore
  # alias MySportsFeeds.Entities.PlayerStats

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "parse nfl stats json to struct" do
    json_example = File.read!("./test/json_examples/nfl_player_stats_totals.json")

    # IO.puts json_example
    {:ok, s} = Poison.decode(json_example, as: %SeasonalPlayerStats{})

    # IO.inspect s.seasonalPlayerStats.playerStatsTotals
    assert(length(s.playerStatsTotals) == 62)
    %{player: player, stats: stats, team: team} = Enum.at(s.playerStatsTotals, 0)
    assert(player.id == 6924 )
    assert(player.firstName == "Davante")
    assert(player.lastName == "Adams")
    assert(team.abbreviation == "GB")
    # "receiving": {
    #   "targets": 118,
    assert(stats.receiving.targets == 118)
  end

  test "parse mlb stats json to struct" do
    json_example = File.read!("./test/json_examples/mlb_player_stats_totals.json")

    # IO.puts json_example
    {:ok, s} = Poison.decode(json_example, as: %SeasonalPlayerStats{})

    # IO.inspect s.seasonalPlayerStats.playerStatsTotals
    assert(length(s.playerStatsTotals) == 41)
    %{player: player, stats: stats, team: team} = Enum.at(s.playerStatsTotals, 0)
    assert(player.id == 14445 )
    assert(player.firstName == "Jason")
    assert(player.lastName == "Adam")
    assert(player.currentTeam.abbreviation == "KC")
    # not sure why these are not filled out
    # maybe they are prospects?
    assert(player.handedness.bats == nil)
    assert(team.abbreviation == "KC")
    # "receiving": {
    #   "targets": 118,
    assert(stats.receiving.targets == nil)
    assert(stats.batting.atBats == 0)
    assert(stats.pitching.earnedRunAvg == 4.22)

    %{player: injuredPlayer} = Enum.find(s.playerStatsTotals, fn(player) ->
      player.player.id == 11322
    end)

    assert(injuredPlayer.id == 11322 )
    assert(injuredPlayer.handedness.bats == "R")
    assert(injuredPlayer.handedness.throws == "R")
    assert(injuredPlayer.currentInjury.description == "lower-back strain")
    assert(injuredPlayer.currentInjury.playingProbability == "OUT")
  end

  test "parse nfl games json to struct" do
    json_example = File.read!("./test/json_examples/nfl_games.json")

    {:ok, s} = Poison.decode(json_example, as: %Games{})

    assert(length(s.games) == 256)
    %{schedule: schedule, score: score} = Enum.at(s.games, 0)
    assert(schedule.id == 43306 )
    assert(schedule.week == 1)
    assert(schedule.venueAllegiance == "NEUTRAL")
    assert(schedule.scheduleStatus == "NORMAL")
    assert(schedule.originalStartTime == nil)
    assert(schedule.delayedOrPostponedReason == nil)
    assert(schedule.playedStatus == "COMPLETED")
    assert(schedule.awayTeam.abbreviation == "KC")
    assert(schedule.homeTeam.abbreviation == "NE")
    assert(schedule.venue.name == "Gillette Stadium")
    assert(score.awayScoreTotal == 42)
    assert(score.homeScoreTotal == 27)
    [q1, _, _, q4] = score.quarters
    assert(q1.quarterNumber == 1)
    assert(q1.awayScore == 7)
    assert(q1.homeScore == 7)
    assert(q4.quarterNumber == 4)
    assert(q4.awayScore == 21)
    assert(q4.homeScore == 0)
  end

  test "parse nfl boxscore json to struct" do
    json_example = File.read!("./test/json_examples/nfl_boxscore.json")

    {:ok, s} = Poison.decode(json_example, as: %Boxscore{})

    %{game: game, scoring: score} = s
    assert(game.id == 43306 )
    assert(game.week == 1)
    assert(game.venueAllegiance == "NEUTRAL")
    assert(game.scheduleStatus == "NORMAL")
    assert(game.originalStartTime == nil)
    assert(game.delayedOrPostponedReason == nil)
    assert(game.playedStatus == "COMPLETED")
    assert(game.awayTeam.abbreviation == "KC")
    assert(game.homeTeam.abbreviation == "NE")
    assert(game.venue.name == "Gillette Stadium")
    assert(score.awayScoreTotal == 42)
    assert(score.homeScoreTotal == 27)
    [q1, _, _, q4] = score.quarters
    assert(q1.quarterNumber == 1)
    assert(q1.awayScore == 7)
    assert(q1.homeScore == 7)
    assert(q4.quarterNumber == 4)
    [play | _ ] = q4.scoringPlays
    assert(play.playDescription == "(14:19) (Shotgun) A.Smith pass deep right to K.Hunt for 78 yards, TOUCHDOWN.")
  end

  test "list of plays and times from nfl boxscore" do
    json_example = File.read!("./test/json_examples/nfl_boxscore.json")

    {:ok, boxscore} = Poison.decode(json_example, as: %Boxscore{})
    plays = Boxscore.boxscore_alerts(boxscore)
    assert(length(plays) == 20)
    assert(Enum.at(plays, 0).playDescription == "KC-NE 0-6 M.Gillislee up the middle for 2 yards, TOUCHDOWN.")
    assert(Enum.at(plays, 1).playDescription == "KC-NE 0-7 S.Gostkowski extra point is GOOD, Center-J.Cardona, Holder-R.Allen.")
    assert(Enum.at(plays, 2).playDescription == "KC-NE 6-7 (3:10) (Shotgun) A.Smith pass short right to D.Harris for 7 yards, TOUCHDOWN.")
    assert(Enum.at(plays, 2).scoreChange == 6)
    assert(Enum.at(plays, 2).awayScore == 6)
    assert(Enum.at(plays, 2).homeScore == 7)
    assert(Enum.at(plays, 2).quarterSecondsElapsed == 710)
    assert(Enum.at(plays, 2).quarterNumber == 1)
  end


  test "game name shows away team first" do
    json_example = File.read!("./test/json_examples/nfl_boxscore.json")

    {:ok, boxscore} = Poison.decode(json_example, as: %Boxscore{})
    plays = Boxscore.boxscore_alerts(boxscore)
    assert(MySportsFeeds.Entities.Games.Schedule.game_name(boxscore.game) == "KC-NE")
  end
end
