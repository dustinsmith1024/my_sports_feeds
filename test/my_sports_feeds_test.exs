defmodule MySportsFeedsTest do
  use ExUnit.Case
  doctest MySportsFeeds
  alias MySportsFeeds.Entities.SeasonalPlayerStats
  alias MySportsFeeds.Entities.PlayerStatsTotals
  alias MySportsFeeds.Entities.PlayerStats
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Stats
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.Games
  alias MySportsFeeds.Entities.Boxscore
  alias MySportsFeeds.Entities.Playbyplay
  alias MySportsFeeds.Entities.Lineup
  alias MySportsFeeds.Entities.CurrentSeason
  alias MySportsFeeds.Entities.Injuries
  alias MySportsFeeds.Entities.TeamStatsTotals
  alias MySportsFeeds.Entities.TeamStandings
  alias MySportsFeeds.Entities.FeedUpdates
  # alias MySportsFeeds.Entities.PlayerStats

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "parse nfl stats json to struct" do
    json_example = File.read!("./test/json_examples/nfl_player_stats_totals.json")

    {:ok, %PlayerStatsTotals{playerStatsTotals: s} = pst} = Poison.decode(json_example, as: %PlayerStatsTotals{})
    assert(length(pst.playerStatsTotals) == 62)
    %{player: player, stats: stats, team: team} = Enum.at(pst.playerStatsTotals, 0)
    assert(player.id == 6924 )
    assert(player.firstName == "Davante")
    assert(player.lastName == "Adams")
    assert(team.abbreviation == "GB")
    assert(stats.receiving.targets == 118)
  end

  test "parse nfl team stats json to struct" do
    json_example = File.read!("./test/json_examples/nfl_team_stats_totals.json")

    # IO.puts json_example
    {:ok, %TeamStatsTotals{teamStatsTotals: [teamStats | _ ]}} = Poison.decode(json_example, as: %TeamStatsTotals{})

    # IO.inspect s.seasonalPlayerStats.playerStatsTotals
    # assert(length(s.playerStatsTotals) == 62)
    assert(teamStats.team.abbreviation == "KC")
    assert(teamStats.stats.passing.qBRating == 100.8)
    assert(teamStats.stats.passing.passAttempts == 543)
    assert(teamStats.stats.rushing.rushLng == 504)
    assert(teamStats.stats.receiving.recAverage == 11.9)
    assert(teamStats.stats.tackles.tackleTotal == 921)
    assert(teamStats.stats.interceptions.interceptions == 16)
    assert(teamStats.stats.fumbles.fumForced == 13)
    assert(teamStats.stats.kickoffReturns.krTD == 0)
    assert(teamStats.stats.puntReturns.prTD == 1)
    assert(teamStats.stats.fieldGoals.fgPct == 91.1)
    assert(teamStats.stats.extraPointAttempt.xpMade == 40)
    assert(teamStats.stats.kickoffs.koRetAvgYds == 20.7)
    assert(teamStats.stats.punting.puntAvg == 45.6)
    assert(teamStats.stats.miscellaneous.fourthDownsPct == 30)
    assert(teamStats.stats.standings."Wins" == 10)
    assert(teamStats.stats.standings."Losses" == 6)
  end

  test "parse nfl team standings json to struct" do
    json_example = File.read!("./test/json_examples/nfl_standings.json")

    # IO.puts json_example
    {:ok, %TeamStandings{teams: [teamStanding | _ ]}} = Poison.decode(json_example, as: %TeamStandings{})

    # IO.inspect s.seasonalPlayerStats.playerStatsTotals
    # assert(length(s.playerStatsTotals) == 62)
    assert(teamStanding.team.abbreviation == "ARI")
    assert(teamStanding.stats.passing.qBRating == 76.5)
    assert(teamStanding.stats.rushing.rushAttempts == 408)
    assert(teamStanding.overallRank.rank == 18)
    assert(teamStanding.overallRank.gamesBack == 5)
    assert(teamStanding.conferenceRank.conferenceName == "NFC")
    assert(teamStanding.conferenceRank.rank == 10)
    assert(teamStanding.conferenceRank.gamesBack == 5)
    assert(teamStanding.divisionRank.divisionName == "NFC West")
    assert(teamStanding.divisionRank.rank == 3)
    assert(teamStanding.divisionRank.gamesBack == 3)

    assert(teamStanding.playoffRank.conferenceName == "NFC")
    assert(teamStanding.playoffRank.rank == 10)
    assert(teamStanding.playoffRank.appliesTo == "CONFERENCE")
  end

  test "parse mlb stats json to struct" do
    json_example = File.read!("./test/json_examples/mlb_player_stats_totals.json")

    {:ok, %PlayerStatsTotals{} = s} = Poison.decode(json_example, as: %PlayerStatsTotals{})
    # seasonalPlayerStats
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

  test "parse nfl lineups json to struct" do
    json_example = File.read!("./test/json_examples/nfl_lineup.json")

    {:ok, lineup} = Poison.decode(json_example, as: %Lineup{})

    assert(lineup.game.homeTeam.abbreviation == "NE")
    assert(lineup.game.awayTeam.abbreviation == "PHI")
    [team1, team2] = lineup.teamLineups
    [player1 | _] = team1.actual.lineupPositions
    [player2 | _] = team2.actual.lineupPositions
    assert(player1.player.firstName == "Jay")
    assert(player2.player.firstName == "Dion")
  end

  test "parse nfl current season json to struct" do
    json_example = File.read!("./test/json_examples/nfl_currentseason.json")

    {:ok, %CurrentSeason{seasons: [season | _]}} = Poison.decode(json_example, as: %CurrentSeason{})
    assert(season.name == "2017 Regular")
    assert(season.slug == "2017-regular")
    assert(season.startDate == "2017-09-08Z")
    assert(season.endDate == "2017-12-31Z")
    assert(season.seasonInterval == "REGULAR")
  end


  test "parse nfl injuries json to struct" do
    json_example = File.read!("./test/json_examples/nfl_injuries.json")

    {:ok, %Injuries{players: [player | _]}} = Poison.decode(json_example, as: %Injuries{})
    assert(player.id == 7602)
    assert(player.firstName == "Alan")
    assert(player.lastName == "Branch")
    assert(player.jerseyNumber == 97)
    assert(player.currentInjury.description == "knee")
    assert(player.currentInjury.playingProbability == "QUESTIONABLE")
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

  test "parse nfl playbyplay json to struct" do
    json_example = File.read!("./test/json_examples/nfl_playbyplay.json")

    {:ok, s} = Poison.decode(json_example, as: %Playbyplay{})

    %{game: game, plays: [play | [play2 | _] ]} = s
    assert(game.id == 43426 )
    assert(game.week == 22)
    assert(game.venueAllegiance == "NEUTRAL")
    assert(game.scheduleStatus == "NORMAL")
    assert(game.originalStartTime == nil)
    assert(game.delayedOrPostponedReason == nil)
    assert(game.playedStatus == "COMPLETED")
    assert(game.awayTeam.abbreviation == "PHI")
    assert(game.homeTeam.abbreviation == "NE")
    assert(game.venue.name == "Gillette Stadium")
    assert(play.quarter == 1)
    assert(play.secondsElapsed == 0)
    assert(play.currentDown == 0)
    assert(play.yardsRemaining == 0)
    assert(play.lineOfScrimmage.team.abbreviation == "NE")
    assert(play.lineOfScrimmage.yardLine == 35)
    assert(play.description == "S.Gostkowski kicks 64 yards from NE 35 to PHI 1. C.Clement pushed ob at PHI 26 for 25 yards (P.Chung).")
    assert(play2.description == "(14:54) N.Foles pass short right to N.Agholor to PHI 30 for 4 yards (K.Van Noy).")
    assert(play2.pass.receivingPlayer.firstName == "Nelson")
    assert(play2.pass.passingPlayer.firstName == "Nick")
    assert(play2.pass.receivedAtPosition.yardLine == 31)
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

  test "parse nfl latest updates to struct" do
    json_example = File.read!("./test/json_examples/nfl_latest_updates.json")

    {:ok, %FeedUpdates{feedUpdates: [feedUpdate | [feed2 | _] ] = feedUpdates}} = Poison.decode(json_example, as: %FeedUpdates{})
    boxscoreUpdate = Enum.find(feedUpdates, fn(update) ->
      update.feed.abbreviation == "GAME_BOXSCORE"
    end)

    [ firstGame | _ ] = boxscoreUpdate.forGames
    assert(firstGame.lastUpdatedOn == "2018-07-19T20:38:12.000Z")
    assert(firstGame.game.id == 40464)
    assert(firstGame.game.week == 7)

    assert(feedUpdate.feed.abbreviation == "SEASONAL_GAMES")
    assert(feedUpdate.lastUpdatedOn == "2018-08-14T14:24:25.000Z")
    assert(feed2.feed.abbreviation == "DAILY_GAMES")

    [firstForDate | _] = feed2.forDates
    assert(firstForDate.forDate == "2017-09-07Z")
    assert(firstForDate.lastUpdatedOn == "2018-08-14T14:24:25.000Z")
  end
end
