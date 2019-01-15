defmodule MySportsFeeds.V2.NFL do
  require Logger
  alias MySportsFeeds.Request
  alias MySportsFeeds.Entities.Games
  alias MySportsFeeds.Entities.Boxscore
  alias MySportsFeeds.Entities.Lineup
  alias MySportsFeeds.Entities.CurrentSeason
  alias MySportsFeeds.Entities.Injuries
  alias MySportsFeeds.Entities.TeamStatsTotals
  alias MySportsFeeds.Entities.PlayerStatsTotals
  alias MySportsFeeds.Entities.Venues
  alias MySportsFeeds.Entities.Players
  alias MySportsFeeds.Entities.TeamStandings
  alias MySportsFeeds.Entities.FeedUpdates

  @moduledoc """
  API for National Football League (NFL).
  """

  @doc """
  Fetch NBA stats for a date.

  ## Examples

      iex(2)> {k, s} = MySportsFeeds.NFL.daily_player_stats("2016-09-11", %{force: true})
      11:13:00.002 [info]  Go for URL: https://api.mysportsfeeds.com/v1.2/pull/nfl/2016-2017-regular/daily_player_stats.json?fordate=20160911&force=true
      11:13:09.506 [info]  Got results...parsing
      {:ok,
      %{"dailyplayerstats" => %{"lastUpdatedOn" => "2016-12-10 3:31:46 PM",
       "playerstatsentry" => [%{"player" => %{"FirstName" => "Jared",
          "ID" => "6923", "JerseyNumber" => "84", "LastName" => "Abbrederis",
          "Position" => "WR"},
        "stats" => %{"FumForced" => %{"#text" => "0",
            "@abbreviation" => "Forced", "@category" => "Fumbles"},
          "IntYds" => %{"#text" => "0", "@abbreviation" => "Yds",
            "@category" => "Interceptions"},
          "KrLng" => %{"#text" => "0", "@abbreviation" => "Lng",
            "@category" => "Kickoff Returns"},
          "Sacks" => %{"#text" => "0.0", "@abbreviation" => "Sacks",
            "@category" => "Tackles"},
          "FumRecYds" => %{"#text" => "0", "@abbreviation" => "RecYds",
            "@category" => "Fumbles"},
          "PrRet" => %{"#text" => "0", "@abbreviation" => "Ret",
            "@category" => "Punt Returns"},
          "FumOppRec" => %{"#text" => "0", "@abbreviation" => "OppRec",
            "@category" => "Fumbles"},
          "KrFC" => %{"#text" => "0", "@abbreviation" => "FC",
            "@category" => "Kickoff Returns"},
          "RushYards" => %{"#text" => "0", "@abbreviation" => "Yds",
            "@category" => "Rushing"},
          "PrFum" => %{"#text" => "0", "@abbreviation" => "Fum",
            "@category" => "Punt Returns"},
          "Kr20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
            "@category" => "Kickoff Returns"},
          "KrTD" => %{"#text" => "0", "@abbreviation" => "TD",
            "@category" => "Kickoff Returns"},
          "SackYds" => %{"#text" => "0", "@abbreviation" => "SackYds",
            "@category" => "Tackles"},
          "Rec40Plus" => %{"#text" => "0", "@abbreviation" => "40+",
            "@category" => "Receiving"},
          "TwoPtRushMade" => %{"#text" => "0", "@abbreviation" => "2PTRushMade",
            "@category" => "2PT"},
          "PrAvg" => %{"#text" => "0.0", "@abbreviation" => "Avg",
            "@category" => "Punt Returns"},
          "TwoPtPassRec" => %{"#text" => "0", "@abbreviation" => "2PTPassRec",
            "@category" => "2PT"},
          "PassPct" => %{"#text" => "0.0", "@abbreviation" => "Pct",
            "@category" => "Passing"},
          "Stuffs" => %{"#text" => "0", "@abbreviation" => "Stuffs",
            "@category" => "Interceptions"},
          "PassInt" => %{"#text" => "0", "@abbreviation" => "Int",
            "@category" => "Passing"},
          "PassYardsPerAtt" => %{"#text" => "0.0",
            "@abbreviation" => "Yards/Att", "@category" => "Passing"},
          "Interceptions" => %{"#text" => "0", "@abbreviation" => "Int",
            "@category" => "Interceptions"},
          "Pass20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
            "@category" => "Passing"},
          "KrRet" => %{"#text" => "0", "@abbreviation" => "Ret",
            "@category" => "Kickoff Returns"},
          "IntTD" => %{"#text" => "0", "@abbreviation" => "TD",
            "@category" => "Interceptions"},
          "KB" => %{"#text" => "0", "@abbreviation" => "KB",
            "@category" => "Interceptions"},
          "Rush40Plus" => %{"#text" => "0", "@abbreviation" => "40+",
            "@category" => "Rushing"},
          "FumTotalRec" => %{"#text" => "0", "@abbreviation" => "TotalRec",
            "@category" => "Fumbles"},
          "PassSackY" => %{"#text" => "0", "@abbreviation" => "SackY",
            "@category" => "Passing"},
          "Rec20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
            "@category" => "Receiving"},
          "TwoPtPassAtt" => %{"#text" => "0", "@abbreviation" => "2PTPassAtt",
            "@category" => "2PT"},
          "PassTD" => %{"#text" => "0", "@abbreviation" => "TD",
            "@category" => "Passing"},
          "RecYards" => %{"#text" => "8", "@abbreviation" => "Yds",
            "@category" => "Receiving"},
          "PassTDPct" => %{"#text" => "0.0", "@abbreviation" => "TD%",
            "@category" => "Passing"},
          "Rush20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
            "@category" => "Rushing"},
          "KrAvg" => %{"#text" => "0.0", "@abbreviation" => "Avg",
            "@category" => "Kickoff Returns"},
          "FumTD" => %{"#text" => "0", "@abbreviation" => "TD",
            "@category" => "Fumbles"},
          "RecFumbles" => %{"#text" => "0", "@abbreviation" => "Fumbles",
            "@category" => "Receiving"},
          "TacklesForLoss" => %{"#text" => "0", "@abbreviation" => "TFL",
            "@category" => "Tackles"},
          "TackleSolo" => %{"#text" => "0", "@abbreviation" => "Solo",
            "@category" => "Tackles"},
          "Pr40Plus" => %{"#text" => "0", "@abbreviation" => "40+",
            "@category" => "Punt Returns"},
          "RushTD" => %{"#text" => "0", "@abbreviation" => "TD",
            "@category" => "Rushing"},
          "RushFumbles" => %{"#text" => "0", "@abbreviation" => "Fum", ...},
          "TwoPtAtt" => %{"#text" => "0", ...}, "PrTD" => %{...}, ...},
        "team" => %{"Abbreviation" => "GB", "City" => "Green Bay", "ID" => "62",
          "Name" => "Packers"}},

      iex(8)> s["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("team")
      %{"Abbreviation" => "GB", "City" => "Green Bay", "ID" => "62",
        "Name" => "Packers"}
      iex(9)> s["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("player")
      %{"FirstName" => "Jared", "ID" => "6923", "JerseyNumber" => "84",
        "LastName" => "Abbrederis", "Position" => "WR"}
      iex(11)> s["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("stats")  |> Map.get("RecYards")
      %{"#text" => "8", "@abbreviation" => "Yds", "@category" => "Receiving"}
  """
  def daily_player_stats(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    # Filters are a common separated list
    # https://api.mysportsfeeds.com/v1.2/pull/nba/latest/daily_player_stats.json
    #   ?fordate=20170426&player=kent-bazemore,bradley-beal
    #   &playerstats=2PA,REB,OREB,DREB
    # team={list-of-teams} (filter teams)
    # player={list-of-players} (filter players)
    # position={list-of-positions} (filter player positions)
    # country={list-of-countries} (filter player countries of birth)
    # playerstats={list-of-player-stats} (filter player stats)
    # force={force-if-not-modified} (force content)
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", "")}
    |> Map.merge(opts)
    |> URI.encode_query

    # date format is "2016-11-04"
    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/daily_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Get all the players stats for the whole season.

  ## Examples

      iex(14)> {k, s} = MySportsFeeds.NFL.cumulative_player_stats("latest", %{force: true})
      iex(13)> s["cumulativeplayerstats"]["playerstatsentry"] |> hd
      %{"player" => %{"FirstName" => "Isa", "ID" => "6899", "JerseyNumber" => "42",
      "LastName" => "Abdul-Quddus", "Position" => "DB"},
      "stats" => %{"FumForced" => %{"#text" => "0", "@abbreviation" => "Forced",
        "@category" => "Fumbles"},
      "IntYds" => %{"#text" => "0", "@abbreviation" => "Yds",
        "@category" => "Interceptions"},
      "KrLng" => %{"#text" => "0", "@abbreviation" => "Lng",
        "@category" => "Kickoff Returns"},
      "Sacks" => %{"#text" => "0.0", "@abbreviation" => "Sacks",
        "@category" => "Tackles"},
      "FumRecYds" => %{"#text" => "0", "@abbreviation" => "RecYds",
        "@category" => "Fumbles"},
      "PrRet" => %{"#text" => "0", "@abbreviation" => "Ret",
        "@category" => "Punt Returns"},
      "FumOppRec" => %{"#text" => "0", "@abbreviation" => "OppRec",
        "@category" => "Fumbles"},
      "KrFC" => %{"#text" => "0", "@abbreviation" => "FC",
        "@category" => "Kickoff Returns"},
      "PrFum" => %{"#text" => "0", "@abbreviation" => "Fum",
        "@category" => "Punt Returns"},
      "Kr20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
        "@category" => "Kickoff Returns"},
      "KrTD" => %{"#text" => "0", "@abbreviation" => "TD",
        "@category" => "Kickoff Returns"},
      "SackYds" => %{"#text" => "0", "@abbreviation" => "SackYds",
        "@category" => "Tackles"},
      "PrAvg" => %{"#text" => "0.0", "@abbreviation" => "Avg",
        "@category" => "Punt Returns"},
      "Stuffs" => %{"#text" => "0", "@abbreviation" => "Stuffs",
        "@category" => "Interceptions"},
      "GamesPlayed" => %{"#text" => "1", "@abbreviation" => "G"},
      "Interceptions" => %{"#text" => "0", "@abbreviation" => "Int",
        "@category" => "Interceptions"},
      "KrRet" => %{"#text" => "0", "@abbreviation" => "Ret",
        "@category" => "Kickoff Returns"},
      "IntTD" => %{"#text" => "0", "@abbreviation" => "TD",
        "@category" => "Interceptions"},
      "KB" => %{"#text" => "0", "@abbreviation" => "KB",
        "@category" => "Interceptions"},
      "FumTotalRec" => %{"#text" => "0", "@abbreviation" => "TotalRec",
        "@category" => "Fumbles"},
      "KrAvg" => %{"#text" => "0.0", "@abbreviation" => "Avg",
        "@category" => "Kickoff Returns"},
      "FumTD" => %{"#text" => "0", "@abbreviation" => "TD",
        "@category" => "Fumbles"},
      "TacklesForLoss" => %{"#text" => "0", "@abbreviation" => "TFL",
        "@category" => "Tackles"},
      "TackleSolo" => %{"#text" => "0", "@abbreviation" => "Solo",
        "@category" => "Tackles"},
      "Pr40Plus" => %{"#text" => "0", "@abbreviation" => "40+",
        "@category" => "Punt Returns"},
      "PrTD" => %{"#text" => "0", "@abbreviation" => "TD",
        "@category" => "Punt Returns"},
      "KrFum" => %{"#text" => "0", "@abbreviation" => "Fum",
        "@category" => "Kickoff Returns"},
      "Fumbles" => %{"#text" => "0", "@abbreviation" => "Fum",
        "@category" => "Fumbles"},
      "Pr20Plus" => %{"#text" => "0", "@abbreviation" => "20+",
        "@category" => "Punt Returns"},
      "Safeties" => %{"#text" => "0", "@abbreviation" => "Sfty",
        "@category" => "Interceptions"},
      "TackleAst" => %{"#text" => "0", "@abbreviation" => "Ast",
        "@category" => "Tackles"},
      "Kr40Plus" => %{"#text" => "0", "@abbreviation" => "40+",
        "@category" => "Kickoff Returns"},
      "FumOwnRec" => %{"#text" => "0", "@abbreviation" => "OwnRec",
        "@category" => "Fumbles"},
      "PrLng" => %{"#text" => "0", "@abbreviation" => "Lng",
        "@category" => "Punt Returns"},
      "IntLng" => %{"#text" => "0", "@abbreviation" => "Lng",
        "@category" => "Interceptions"},
      "PassesDefended" => %{"#text" => "0", "@abbreviation" => "PD",
        "@category" => "Interceptions"},
      "FumLost" => %{"#text" => "0", "@abbreviation" => "Lost",
        "@category" => "Fumbles"},
      "IntAverage" => %{"#text" => "0.0", "@abbreviation" => "Avg",
        "@category" => "Interceptions"},
      "PrFC" => %{"#text" => "0", "@abbreviation" => "FC",
        "@category" => "Punt Returns"},
      "StuffYds" => %{"#text" => "0", "@abbreviation" => "StuffYds",
        "@category" => "Interceptions"},
      "TackleTotal" => %{"#text" => "0", "@abbreviation" => "Total",
        "@category" => "Tackles"},
      "KrYds" => %{"#text" => "0", "@abbreviation" => "Yds",
        "@category" => "Kickoff Returns"},
      "PrYds" => %{"#text" => "0", "@abbreviation" => "Yds",
        "@category" => "Punt Returns"}},
    "team" => %{"Abbreviation" => "MIA", "City" => "Miami", "ID" => "49",
      "Name" => "Dolphins"}}
  """
  def cumulative_player_stats(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/cumulative_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Player stat totals for the season.

  https://api.mysportsfeeds.com/v2.0/pull/nfl/2017-regular/player_stats_totals.json?team=GB
  https://api.mysportsfeeds.com/v2.0/pull/nfl/2017-regular/player_stats_totals.json?team=KC&player=kareem-hunt"

  Examples:

    iex(2)> MySportsFeeds.V2.NFL.player_stats_totals(%{team: "KC", season: "2017-regular"})
  """

  def player_stats_totals(opts \\ %{}) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/player_stats_totals.json?#{query_params}"
    |> req(%PlayerStatsTotals{})
  end

  @doc """
  Gets the schedule for the season.

  iex(2)> MySportsFeeds.V2.NFL.games()
  iex(2)> MySportsFeeds.V2.NFL.games(%{date: "20180204"})
  iex(2)> MySportsFeeds.V2.NFL.games(%{date: "20180204", force: false})
  """
  def games(opts \\ %{}) do
    season = Map.get(opts, :season, "latest")
    date = Map.get(opts, :date, "") |> String.replace("-", "")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> Map.delete(:date)
    |> URI.encode_query

    # Append a day for filtering,  i think it would work as a query param tho
    season_date = case date do
      "" -> season
      nil -> season
      day when is_bitstring(day) ->
        "#{season}/date/#{day}"
    end

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season_date}/games.json?#{query_params}"
    |> req(%Games{})
  end

  @doc """
  Gets the schedule for a date.

  ## Examples:

      iex(27)> {status, stats} = MySportsFeeds.NFL.daily_game_schedule("2016-09-11", "2016-2017-regular", %{force: true})
      iex(26)> stats["dailygameschedule"]["gameentry"] |> hd
      %{"awayTeam" => %{"Abbreviation" => "GB", "City" => "Green Bay", "ID" => "62",
          "Name" => "Packers"}, "date" => "2016-09-11",
        "homeTeam" => %{"Abbreviation" => "JAX", "City" => "Jacksonville",
          "ID" => "66", "Name" => "Jaguars"}, "id" => "30904",
        "location" => "EverBank Field", "time" => "1:00PM"}
  """
  def daily_game_schedule(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    # TODO: Make a 'today' method
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/daily_game_schedule.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  Play by play for an NFL game.

  (game date as YYYYMMDD) + "-" +
  (away team abbreviation) + "-" +
  (home team abbreviation)

  ## Examples:

      iex(40)> {status, stats} = MySportsFeeds.NFL.game_play_by_play("20160911-NE-ARI", "2016-2017-regular", %{force: true})
      iex(40)> stats["gameplaybyplay"]["plays"]["play"] |> hd
      %{"currentDown" => "1",
        "description" => "(15:00) D.Johnson left tackle to ARI 27 for 2 yards (A.Branch).",
        "lineOfScrimmage" => %{"team" => "ARI", "yardLine" => "25"}, "quarter" => "1",
        "rushingPlay" => %{"isEndedWithTouchdown" => "false",
          "isFirstDownPenalty" => "false", "isNoPlay" => "false",
          "isOutOfBounds" => "false", "isTackled" => "true",
          "isTwoPointConversion" => "false",
          "rushingPlayer" => %{"FirstName" => "David", "ID" => "5940",
            "JerseyNumber" => "31", "LastName" => "Johnson", "Position" => "RB"},
          "soloTacklingPlayer" => %{"FirstName" => "Alan", "ID" => "7602",
            "JerseyNumber" => "97", "LastName" => "Branch", "Position" => "NT"},
          "stoppedAtPosition" => %{"team" => "ARI", "yardLine" => "27"},
          "teamAbbreviation" => "ARI", "yardsRushed" => "2"}, "time" => "0:00",
        "yardsRemaining" => "10"}
  """
  def game_play_by_play(game, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    # TODO: Smarter caching on these if the games are completed
    query_params = %{
      force: "false",
      gameid: game,
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/game_playbyplay.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Get the boxscore for a game

  iex(5)> {:ok, box} = MySportsFeeds.V2.NFL.playbyplay(%{game: "20180204-PHI-NE"})

  # Get just the scoring plays
  iex(5)> MySportsFeeds.Entities.Boxscore.boxscore_alerts(box)
  """
  def playbyplay(%{game: game} = opts) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> Map.delete(:game)
    |> URI.encode_query

    # Append a day for filtering,  i think it would work as a query param tho
    season_game = case game do
      "" -> season
      nil -> season
      game_id when is_bitstring(game_id) ->
        "#{season}/games/#{game_id}"
    end

    case Request.raw_get("https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season_game}/playbyplay.json?#{query_params}") do
      {:ok, false} ->
        Logger.debug("probably cached...")
        {:ok, false}
      {:ok, games} ->
        Poison.decode(games, as: %Boxscore{})
      some_error -> some_error
    end
  end

  @doc """
  Get the boxscore for a game

  iex(5)> {:ok, box} = MySportsFeeds.V2.NFL.boxscore(%{game: "20180204-PHI-NE"})

  # Get just the scoring plays
  iex(5)> MySportsFeeds.Entities.Boxscore.boxscore_alerts(box)
  """
  def boxscore(%{game: game} = opts) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> Map.delete(:game)
    |> URI.encode_query

    # Append a day for filtering,  i think it would work as a query param tho
    season_game = case game do
      "" -> season
      nil -> season
      game_id when is_bitstring(game_id) ->
        "#{season}/games/#{game_id}"
    end

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season_game}/boxscore.json?#{query_params}"
    |> req(%Boxscore{})
  end

  def boxscore(game_id) do
    boxscore(%{game: game_id})
  end

  def player_gamelogs() do
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/2017-regular/week/15/player_gamelogs.json?team=KC"
  end

  def dfs() do
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/2017-regular/week/15/dfs.json?team=KC"
  end

  def team_gamelogs() do
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/2017-regular/week/15/team_gamelogs.json?team=KC"
  end

  # "https://api.mysportsfeeds.com/v2.0/pull/nfl/2018-playoffs/games/20180204-PHI-NE/lineup.json"
  # {:ok, lineup} = MySportsFeeds.V2.NFL.lineup(%{game: "20180204-PHI-NE"})
  def lineup(%{game: game} = opts) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> Map.delete(:game)
    |> URI.encode_query

    # Append a day for filtering,  i think it would work as a query param tho
    season_game = case game do
      "" -> season
      nil -> season
      game_id when is_bitstring(game_id) ->
        "#{season}/games/#{game_id}"
    end

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season_game}/lineup.json?#{query_params}"
    |> req(%Lineup{})
  end


  # date is common here
  # if you dont send a date then its today
  def current_season(opts \\ %{}) do
    # date = Map.get(opts, :date, "20171212") # TODO: Make today
    # |> String.replace("-", "")

    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> URI.encode_query
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/current_season.json?#{query_params}"
    |> req(%CurrentSeason{})
  end

  # team=NE
  def injuries(opts \\ %{}) do
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/injuries.json?#{query_params}"
    |> req(%Injuries{})
  end

  def latest_updates(opts \\ %{}) do
    season = Map.get(opts, :season, "2017-regular")
    query_params = %{
      force: "true",
      version: "v2_0",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/latest_updates.json?#{query_params}"
    |> req(%FeedUpdates{})
  end

  def team_stats_totals(opts \\ %{}) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/team_stats_totals.json?#{query_params}"
    |> req(%TeamStatsTotals{})
  end

  @doc """
  Team venues with home team.

  Examples:
    iex(2)> MySportsFeeds.V2.NFL.venues
  """
  def venues(), do: venues(%{})
  def venues(%{} = opts) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> URI.encode_query
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/venues.json?#{query_params}"
    |> req(%Venues{})
  end

  @doc """
  rosterstatus={list-of-roster-statuses} (filter roster statuses)

  """
  def players(), do: players(%{})
  def players(%{} = opts) do
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> URI.encode_query
    "https://api.mysportsfeeds.com/v2.0/pull/nfl/players.json?#{query_params}"
    |> req(%Players{})
  end

  def standings(), do: standings(%{})
  def standings(%{} = opts) do
    season = Map.get(opts, :season, "latest")
    query_params = %{
      force: "true",
    }
    |> Map.merge(opts)
    |> Map.delete(:season) # we probably dont have to delete these but its safer
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/standings.json?#{query_params}"
    |> req(%TeamStandings{})
  end

  def req(url, struct) do
    case Request.raw_get(url) do
      {:ok, false} ->
        Logger.debug("probably cached...")
        {:ok, false}
      {:ok, games} ->
        Poison.decode(games, as: struct)
      some_error -> some_error
    end
  end
  # def boxscore(opts \\ %{}) do
  #   Logger.warn "Send in a game"
  # end

  @doc """
  Get scores of all games on a day.

  ## Examples:

      iex(4)> {s, p} = MySportsFeeds.NFL.scoreboard("20160911")
      iex(4)> game = p["scoreboard"]["gameScore"] |> hd
      iex(17)> game["game"]["awayTeam"]["Name"] <> " " <>  game["awayScore"] <> "-" <> " " <> game["game"]["homeTeam"]["Name"] <> " " <>  game["homeScore"]
      "Packers 27- Jaguars 23"

      iex(15)> {s, p} = MySportsFeeds.NFL.scoreboard("20160911", "2016-regular", %{force: true})
      21:07:46.802 [info]  Go for URL: https://api.mysportsfeeds.com/v1.2/pull/nfl/2016-regular/scoreboard.json?fordate=20160911&force=true
      21:07:47.024 [info]  Got results...parsing
      {:ok,
      %{"scoreboard" => %{"gameScore" => [%{"awayScore" => "27",
              "game" => %{"ID" => "30904",
                "awayTeam" => %{"Abbreviation" => "GB", "City" => "Green Bay",
                  "ID" => "62", "Name" => "Packers"}, "date" => "2016-09-11",
                "homeTeam" => %{"Abbreviation" => "JAX", "City" => "Jacksonville",
                  "ID" => "66", "Name" => "Jaguars"}, "location" => "EverBank Field",
                "time" => "1:00PM"}, "homeScore" => "23", "isCompleted" => "true",
              "isInProgress" => "false", "isUnplayed" => "false",
              "quarterSummary" => %{"quarter" => [%{"@number" => "1",
                  "awayScore" => "7", "homeScore" => "7"},
                %{"@number" => "2", "awayScore" => "14", "homeScore" => "10"},
                %{"@number" => "3", "awayScore" => "3", "homeScore" => "3"},
                %{"@number" => "4", "awayScore" => "3", "homeScore" => "3"}]}},
  """
  def scoreboard(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/scoreboard.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Players that are on a roster for the date passed in.

  ## Examples:

    iex(18)> {s, p} = MySportsFeeds.NFL.roster_players("20170406")
    iex(21)> p["rosterplayers"]["playerentry"] |> List.last()
    %{"player" => %{"FirstName" => "Frank", "Height" => "6'3\"", "ID" => "7344",
      "IsRookie" => "false", "JerseyNumber" => "51", "LastName" => "Zombo",
      "Position" => "LB", "Weight" => "254"},
      "team" => %{"Abbreviation" => "KC", "City" => "Kansas City", "ID" => "73",
        "Name" => "Chiefs"}}
  """
  def roster_players(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/roster_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Daily fantasy salaries from Draft Kings and Fan Duel.

  ## Examples:
    # No examples yet, since the season hasn't started.

    iex(41)> {s, p} = MySportsFeeds.NFL.daily_dfs("2017-04-06")

    {:ok,
    %{"dailydfs" => %{"dfsEntries" => [%{"dfsRows" => [%{"game" => %{"awayTeam" => %{"Abbreviation" => "MIN",
                  "City" => "Minnesota", "ID" => "100", "Name" => "Timberwolves"},
                "date" => "2017-04-06",
                "homeTeam" => %{"Abbreviation" => "POR", "City" => "Portland",
                  "ID" => "97", "Name" => "Trail Blazers"}, "id" => "35118",
                "time" => "10:30PM"},
              "player" => %{"FirstName" => "Karl-Anthony", "ID" => "9346",
                "LastName" => "Towns", "Position" => "C",
                "dfsSourceId" => "837030"}, "salary" => "10200",
              "team" => %{"Abbreviation" => "MIN", "City" => "Minnesota",
                "ID" => "100", "Name" => "Timberwolves"}},

    iex(50)> p["dailydfs"]["dfsEntries"] |> tl |> hd |> Map.get("dfsType")
    "FanDuel"
    iex(51)> p["dailydfs"]["dfsEntries"] |> hd |> Map.get("dfsType")
    "DraftKings"

    iex(58)> Enum.each(dfs["dfsRows"], fn(row) -> IO.puts row["player"]["FirstName"] <> " " <> row["player"]["LastName"] <> " - " <> row["salary"] end)
    Karl-Anthony Towns - 10200
    John Wall - 9900
    Giannis Antetokounmpo - 9800
    Jimmy Butler - 9700
    Paul George - 8900
    Damian Lillard - 8800
    Isaiah Thomas - 8600
  """
  def daily_dfs(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/daily_dfs.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Fetch all active players regardless if they are on a roster or not.

  ## Examples:

    iex(31)> {s, p} = MySportsFeeds.NFL.active_players
      {:ok,
      %{"activeplayers" => %{"lastUpdatedOn" => "2017-02-06 7:51:03 AM",
          "playerentry" => [%{"player" => %{"Age" => "26",
                "BirthCity" => "West Allis, WI", "BirthCountry" => "USA",
                "BirthDate" => "1990-12-17", "FirstName" => "Jared",
                "Height" => "6'1\"", "ID" => "6923", "IsRookie" => "false",
                "JerseyNumber" => "84", "LastName" => "Abbrederis",
                "Position" => "WR", "Weight" => "195"},
              "team" => %{"Abbreviation" => "GB", "City" => "Green Bay", "ID" => "62",
                "Name" => "Packers"}},
  """
  def active_players(season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/active_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  def overall_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    # teamstats={team-stats}&

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/overall_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Conference team standings for NFL.
  """
  def conference_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/conference_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Division team standings for NFL.
  """
  def division_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/division_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  Playoff team standings for NFL.
  """
  def playoff_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://api.mysportsfeeds.com/v1.2/pull/nfl/#{season}/playoff_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end
end
