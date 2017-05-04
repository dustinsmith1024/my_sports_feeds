defmodule MySportsFeeds.NFL do
  require Logger
  alias MySportsFeeds.Request

  @doc """
  Fetch NBA stats for a date.

  ## Examples

      iex(2)> {k, s} = MySportsFeeds.NFL.daily_player_stats("2016-09-11", %{force: true})
      11:13:00.002 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_player_stats.json?fordate=20160911&force=true
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
    # https://www.mysportsfeeds.com/api/feed/pull/nba/latest/daily_player_stats.json
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
    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/daily_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  cumulative_player_stats: Get all the players stats for the whole season.

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/cumulative_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  full_game_schedule: gets the schedule for the season.

  iex(20)> {status, stats} = MySportsFeeds.NFL.full_game_schedule
  iex(18)> stats["fullgameschedule"]["gameentry"] |> hd
  %{"awayTeam" => %{"Abbreviation" => "OAK", "City" => "Oakland", "ID" => "74",
      "Name" => "Raiders"}, "date" => "2017-01-07",
    "homeTeam" => %{"Abbreviation" => "HOU", "City" => "Houston", "ID" => "64",
      "Name" => "Texans"}, "id" => "37730", "location" => "NRG Stadium",
    "time" => "4:35PM"}
  """
  def full_game_schedule(season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/full_game_schedule.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  daily_game_schedule: gets the schedule for a date.

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/daily_game_schedule.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/game_playbyplay.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  game_boxscore: Box Score for the game. Includes all scoring plays.

  ## Examples:


      iex(32)> {status, stats} = MySportsFeeds.NFL.game_boxscore("20160911-NE-ARI", "2016-2017-regular", %{force: true})
      iex(37)> stats["gameboxscore"]["quarterSummary"]
      %{"quarter" => [%{"@number" => "1", "awayScore" => "10", "homeScore" => "0",
          "scoring" => %{"scoringPlay" => [%{"playDescription" => "(7:42) J.Garoppolo pass deep left to C.Hogan for 37 yards, TOUCHDOWN.",
                "teamAbbreviation" => "NE", "time" => "7:18"},
              %{"playDescription" => "S.Gostkowski extra point is GOOD, Center-J.Cardona, Holder-R.Allen.",
                "teamAbbreviation" => "NE", "time" => "7:26"},
              %{"playDescription" => "(1:05) S.Gostkowski 47 yard field goal is GOOD, Center-J.Cardona, Holder-R.Allen.",
                "teamAbbreviation" => "NE", "time" => "13:55"}]}},
        %{"@number" => "2", "awayScore" => "0", "homeScore" => "7",
          "scoring" => %{"scoringPlay" => [%{"playDescription" => "(4:10) (Shotgun) C.Palmer pass short left to L.Fitzgerald for 3 yards, TOUCHDOWN.",
                "teamAbbreviation" => "ARI", "time" => "10:50"},
              %{"playDescription" => "C.Catanzaro extra point is GOOD, Center-K.Canaday, Holder-D.Butler.",
                "teamAbbreviation" => "ARI", "time" => "10:54"}]}},
        %{"@number" => "3", "awayScore" => "7", "homeScore" => "7",
          "scoring" => %{"scoringPlay" => [%{"playDescription" => "(10:08) (Shotgun) L.Blount up the middle for 8 yards, TOUCHDOWN.",
                "teamAbbreviation" => "NE", "time" => "4:52"},
              %{"playDescription" => "S.Gostkowski extra point is GOOD, Center-J.Cardona, Holder-R.Allen.",
                "teamAbbreviation" => "NE", "time" => "5:00"},
              %{"playDescription" => "(4:33) (No Huddle) D.Johnson up the middle for 1 yard, TOUCHDOWN. Penalty on NE, Defensive 12 On-field, declined.",
                "teamAbbreviation" => "ARI", "time" => "10:27"},
              %{"playDescription" => "C.Catanzaro extra point is GOOD, Center-K.Canaday, Holder-D.Butler.",
                "teamAbbreviation" => "ARI", "time" => "10:31"}]}},
        %{"@number" => "4", "awayScore" => "6", "homeScore" => "7",
          "scoring" => %{"scoringPlay" => [%{"playDescription" => "(12:40) S.Gostkowski 53 yard field goal is GOOD, Center-J.Cardona, Holder-R.Allen.",
                "teamAbbreviation" => "NE", "time" => "2:20"},
              %{"playDescription" => "(9:51) (Shotgun) C.Palmer pass short left to L.Fitzgerald for 1 yard, TOUCHDOWN.",
                "teamAbbreviation" => "ARI", "time" => "5:09"},
              %{"playDescription" => "C.Catanzaro extra point is GOOD, Center-K.Canaday, Holder-D.Butler. PENALTY on NE-J.Collins, Leaping, 15 yards, enforced between downs.",
                "teamAbbreviation" => "ARI", "time" => "5:14"},
              %{"playDescription" => "(3:48) S.Gostkowski 32 yard field goal is GOOD, Center-J.Cardona, Holder-R.Allen.",
                "teamAbbreviation" => "NE", "time" => "11:12"}]}}],
        "quarterTotals" => %{"awayScore" => "23", "homeScore" => "21"}}
  """
  def game_boxscore(game, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{
      force: "false",
      gameid: game,
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/game_boxscore.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  scoreboard: get scores of all games on a day.

  ## Examples:

      iex(4)> {s, p} = MySportsFeeds.NFL.scoreboard("20160911")
      iex(4)> game = p["scoreboard"]["gameScore"] |> hd
      iex(17)> game["game"]["awayTeam"]["Name"] <> " " <>  game["awayScore"] <> "-" <> " " <> game["game"]["homeTeam"]["Name"] <> " " <>  game["homeScore"]
      "Packers 27- Jaguars 23"

      iex(15)> {s, p} = MySportsFeeds.NFL.scoreboard("20160911", "2016-regular", %{force: true})
      21:07:46.802 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-regular/scoreboard.json?fordate=20160911&force=true
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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/scoreboard.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/roster_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  daily_dfs

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/daily_dfs.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  current_season: Grabs season with some details.

  ## Examples:

    iex(29)> MySportsFeeds.NFL.current_season("2017-01-03")
    {:ok,
    %{"currentseason" => %{"lastUpdatedOn" => "2017-04-22 10:28:05 PM",
        "season" => [%{"details" => %{"endDate" => "2017-02-05",
              "intervalType" => "playoff", "name" => "2017 Playoffs",
              "slug" => "2017-playoff", "startDate" => "2017-01-07"},
            "supportedPlayerStats" => %{"playerStat" => [%{"abbreviation" => "Att",
                "category" => "Passing", "name" => "Pass Attempts"},
              %{"abbreviation" => "Comp", "category" => "Passing",
  """
  def current_season(date, opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/current_season.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  active_players: fetch all active players regardless if they are on a roster or not.

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

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/active_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  latest_updates

  ## Examples:

    iex(40)> {s, p} = MySportsFeeds.NFL.latest_updates
      {:ok,
      %{"latestupdates" => %{"feedentry" => [%{"feed" => %{"Abbreviation" => "CUMULATIVE_PLAYER_STATS",
                "Description" => "A list of player stats totals for all roster players, summarized by their latest team.",
                "Name" => "Cumulative Player Stats"},
              "lastUpdatedOn" => "2017-02-05 11:33:03 PM"},
            %{"feed" => %{"Abbreviation" => "FULL_GAME_SCHEDULE",
                "Description" => "A list of all games to be played for the entire season.",
                "Name" => "Full Game Schedule"},
              "lastUpdatedOn" => "2017-01-24 2:59:35 AM"},
  """
  def latest_updates(season \\ "latest", opts \\ %{}, ttl_seconds \\ 60) do
    query_params = %{
      force: "false",
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/latest_updates.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

end
