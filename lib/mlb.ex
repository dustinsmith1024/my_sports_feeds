defmodule MySportsFeeds.MLB do
  require Logger
  alias MySportsFeeds.Request

  @doc """
  daily_player_stats: Fetch MLB stats for a date.

  ## Examples

    iex(4)> {status, stats} = MySportsFeeds.MLB.daily_player_stats("2017-04-22")

    22:17:58.322 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/mlb/latest/daily_player_stats.json?fordate=20170422&force=false

    22:18:05.789 [info]  Got results...parsing
    {:ok,
    %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-04-22 11:14:07 PM",
        "playerstatsentry" => [%{"player" => %{"FirstName" => "Jose",
            "ID" => "10437", "JerseyNumber" => "79", "LastName" => "Abreu",
            "Position" => "1B"},
            "stats" => %{"BatterSplitters" => %{"#text" => "0",
                "@abbreviation" => "BFS", "@category" => "Batting"},
            "Homeruns" => %{"#text" => "0", "@abbreviation" => "HR",
                "@category" => "Batting"},
            "Runs" => %{"#text" => "0", "@abbreviation" => "R",
                "@category" => "Batting"},
            "HitByPitch" => %{"#text" => "0", "@abbreviation" => "HBP",
                "@category" => "Batting"},
            "BatterCutters" => %{"#text" => "0", "@abbreviation" => "BFC",
                "@category" => "Batting"},

      iex(11)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("team")
        %{"Abbreviation" => "CWS", "City" => "Chicago", "ID" => "119",
        "Name" => "White Sox"}
        iex(12)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("player")
        %{"FirstName" => "Jose", "ID" => "10437", "JerseyNumber" => "79",
        "LastName" => "Abreu", "Position" => "1B"}
      iex(32)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("stats") |> Map.get("BattingAvg")
        %{"#text" => "0.000", "@abbreviation" => "AVG", "@category" => "Batting"}
      iex(9)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("stats") |> Map.keys |> Enum.sort |> Enum.each(fn(e) -> IO.inspect e end)
        "Assists"
        "AtBats"
        "Batter2SeamFastballs"
        "Batter4SeamFastballs"
        "BatterChangeups"
        "BatterCurveballs"
        "BatterCutters"
        "BatterDoublePlays"
        "BatterFlyBalls"
        "BatterFlyOuts"
        "BatterForceOuts"
        "BatterGroundBalls"
        "BatterGroundOutToFlyOutRatio"
        "BatterGroundOuts"
        "BatterIntentionalWalks"
        "BatterLineDrives"
        "BatterOnBasePct"
        "BatterOnBasePlusSluggingPct"
        "BatterPutOuts"
        "BatterSacrificeBunts"
        "BatterSacrificeFlies"
        "BatterSinkers"
        "BatterSliders"
        "BatterSluggingPct"
        "BatterSplitters"
        "BatterStolenBasePct"
        "BatterStrikeouts"
        "BatterStrikes"
        "BatterStrikesFoul"
        "BatterStrikesLooking"
        "BatterStrikesMiss"
        "BatterSwings"
        "BatterTagOuts"
        "BatterTriplePlays"
        "BatterWalks"
        "BattingAvg"
        "CaughtBaseSteals"
        "EarnedRuns"
        "Errors"
        "ExtraBaseHits"
        "FielderCaughtStealing"
        "FielderDoublePlays"
        "FielderForceOuts"
        "FielderPutOuts"
        "FielderStolenBasePct"
        "FielderStolenBasesAllowed"
        "FielderTagOuts"
        "FielderTriplePlays"
        "FielderWildPitches"
        "FieldingPct"
        "GamesStarted"
        "HitByPitch"
        "Hits"
        "Homeruns"
        "InningsPlayed"
        "LeftOnBase"
        "OutsFaced"
        "PassedBalls"
        "PitchesFaced"
        "PlateAppearances"
        "RangeFactor"
        "Runs"
        "RunsBattedIn"
        "SecondBaseHits"
        "StolenBases"
        "ThirdBaseHits"
        "TotalBases"
        "TotalChances"
        "UnearnedRuns"
  """
  def daily_player_stats(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 300) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", "")}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/daily_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  cumulative_player_stats: Get all the players stats for the whole season.

  ## Examples

      iex(17)> {status, stats} = MySportsFeeds.MLB.cumulative_player_stats
        {:ok,
        %{"cumulativeplayerstats" => %{"lastUpdatedOn" => "2017-04-22 5:00:14 AM",
            "playerstatsentry" => [%{"player" => %{"FirstName" => "Fernando",
          "ID" => "10277", "JerseyNumber" => "58", "LastName" => "Abad",
          "Position" => "P"},
        "stats" => %{"Losses" => %{"#text" => "0", "@abbreviation" => "L",
            "@category" => "Pitching"},
          "BatterSplitters" => %{"#text" => "0", "@abbreviation" => "BFS",
            "@category" => "Batting"},
          "Homeruns" => %{"#text" => "0", "@abbreviation" => "HR",
            "@category" => "Batting"},
          "PitcherFlyBalls" => %{"#text" => "2", "@abbreviation" => "FlyB",
            "@category" => "Pitching"},

        iex(16)> stats["cumulativeplayerstats"]["playerstatsentry"] |> hd
  """
  def cumulative_player_stats(season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/cumulative_player_stats.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  full_game_schedule: gets the schedule for the season.

  ## Examples:
    iex(20)> {status, stats} = MySportsFeeds.MLB.full_game_schedule
    iex(20)> stats["fullgameschedule"]["gameentry"] |> hd
        %{"awayTeam" => %{"Abbreviation" => "NYY", "City" => "New York", "ID" => "114",
            "Name" => "Yankees"}, "date" => "2017-04-02",
        "homeTeam" => %{"Abbreviation" => "TB", "City" => "Tampa Bay", "ID" => "115",
            "Name" => "Rays"}, "id" => "40265", "location" => "Tropicana Field",
        "time" => "1:10PM"}
  """
  def full_game_schedule(season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/full_game_schedule.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  daily_game_schedule: gets the schedule for a date.

  ## Examples:

      iex(21)> {status, stats} = MySportsFeeds.MLB.daily_game_schedule("2017-04-22")
      {:ok,
        %{"dailygameschedule" => %{"gameentry" => [%{"awayTeam" => %{"Abbreviation" => "CHC",
          "City" => "Chicago", "ID" => "131", "Name" => "Cubs"},
        "date" => "2017-04-22",
        "homeTeam" => %{"Abbreviation" => "CIN", "City" => "Cincinnati",
          "ID" => "135", "Name" => "Reds"}, "id" => "38422",
        "location" => "Great American Ball Park", "time" => "1:10PM"},
  """
  def daily_game_schedule(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/daily_game_schedule.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """


  (game date as YYYYMMDD) + "-" +
  (away team abbreviation) + "-" +
  (home team abbreviation)

  ## Examples:

      iex(19)> {s, p} = MySportsFeeds.MLB.game_play_by_play("20170422-CHC-CIN")
      iex(19)> p["gameplaybyplay"]["atBats"]["atBat"] |> hd
        %{"atBatPlay" => [%{"batterUp" => %{"battingPlayer" => %{"FirstName" => "Kyle",
                "ID" => "10331", "JerseyNumber" => "12", "LastName" => "Schwarber",
                "Position" => "LF"}, "result" => "WALK",
            "standingLeftOrRight" => "right"}},
        %{"pitch" => %{"ballEndSpeed" => "83", "ballStartSpeed" => "94",
            "battingPlayer" => %{"FirstName" => "Kyle", "ID" => "10331",
                "JerseyNumber" => "12", "LastName" => "Schwarber", "Position" => "LF"},
            "pitchedLocationX" => "160", "pitchedLocationY" => "179",
            "pitchingPlayer" => %{"FirstName" => "Cody", "ID" => "10344",
                "JerseyNumber" => "44", "LastName" => "Reed", "Position" => "P"},
            "result" => "BALL", "throwingLeftOrRight" => "left"}},
        %{"pitch" => %{"ballEndSpeed" => "80", "ballStartSpeed" => "87",
            "battingPlayer" => %{"FirstName" => "Kyle", "ID" => "10331",
                "JerseyNumber" => "12", "LastName" => "Schwarber", "Position" => "LF"},
            "pitchedLocationX" => "156", "pitchedLocationY" => "188",
            "pitchingPlayer" => %{"FirstName" => "Cody", "ID" => "10344",
                "JerseyNumber" => "44", "LastName" => "Reed", "Position" => "P"},
            "result" => "BALL", "throwingLeftOrRight" => "left"}},
        %{"pitch" => %{"ballEndSpeed" => "84", "ballStartSpeed" => "95",
            "battingPlayer" => %{"FirstName" => "Kyle", "ID" => "10331",
                "JerseyNumber" => "12", "LastName" => "Schwarber", "Position" => "LF"},
            "pitchedLocationX" => "158", "pitchedLocationY" => "179",
            "pitchingPlayer" => %{"FirstName" => "Cody", "ID" => "10344",
                "JerseyNumber" => "44", "LastName" => "Reed", "Position" => "P"},
            "result" => "BALL", "throwingLeftOrRight" => "left"}},
        %{"pitch" => %{"ballEndSpeed" => "81", "ballStartSpeed" => "93",
            "battingPlayer" => %{"FirstName" => "Kyle", "ID" => "10331",
                "JerseyNumber" => "12", "LastName" => "Schwarber", "Position" => "LF"},
            "pitchedLocationX" => "125", "pitchedLocationY" => "230",
            "pitchingPlayer" => %{"FirstName" => "Cody", "ID" => "10344",
                "JerseyNumber" => "44", "LastName" => "Reed", "Position" => "P"},
            "result" => "BALL_IN_DIRT", "throwingLeftOrRight" => "left"}},
        %{"baseRunAttempt" => %{"fromBase" => "0", "isEarnedRun" => "false",
            "isForcedOut" => "false", "isPassedBall" => "false",
            "isRunScored" => "false", "isSafe" => "true", "isWalk" => "true",
            "isWalkIntentional" => "false", "isWildPitch" => "false",
            "runningPlayer" => %{"FirstName" => "Kyle", "ID" => "10331",
                "JerseyNumber" => "12", "LastName" => "Schwarber", "Position" => "LF"},
            "toBase" => "1"}}],
        "battingTeam" => %{"Abbreviation" => "CHC", "City" => "Chicago",
            "ID" => "131", "Name" => "Cubs"}, "inning" => "1", "inningHalf" => "top"}
  """
  def game_play_by_play(game, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{
      force: "false",
      gameid: game,
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/game_playbyplay.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  game_boxscore: Box Score for the game. Includes all scoring plays.

  ## Examples:

    iex(21)> {s, p} = MySportsFeeds.MLB.game_boxscore("20170422-CHC-CIN")

    22:35:13.030 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/mlb/latest/game_boxscore.json?gameid=20170422-CHC-CIN&force=false

    22:35:13.455 [info]  Got results...parsing
    {:ok,
    %{"gameboxscore" => %{"awayTeam" => %{"awayPlayers" => %{"playerEntry" => [%{"player" => %{"FirstName" => "Albert",
                "ID" => "10329", "JerseyNumber" => "5",
                "LastName" => "Almora Jr.", "Position" => "CF"},
                "stats" => %{"BatterSplitters" => %{"#text" => "0",
                    "@abbreviation" => "BFS", "@category" => "Batting"},
                "Homeruns" => %{"#text" => "0", "@abbreviation" => "HR",
                    "@category" => "Batting"},
  """
  def game_boxscore(game, season \\ "latest", opts \\ %{}, ttl_seconds \\ 300) do
    query_params = %{
      force: "false",
      gameid: game,
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/game_boxscore.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  scoreboard: get scores of all games on a day.

  ## Examples:

      iex(22)> {s, p} = MySportsFeeds.MLB.scoreboard("20170422")
        22:38:05.808 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/mlb/latest/scoreboard.json?fordate=20170422&force=false

        22:38:06.210 [info]  Got results...parsing
        {:ok,
        %{"scoreboard" => %{"gameScore" => [%{"awayScore" => "12",
                "game" => %{"ID" => "38422",
                "awayTeam" => %{"Abbreviation" => "CHC", "City" => "Chicago",
                    "ID" => "131", "Name" => "Cubs"}, "date" => "2017-04-22",
                "homeTeam" => %{"Abbreviation" => "CIN", "City" => "Cincinnati",
                    "ID" => "135", "Name" => "Reds"},
                "location" => "Great American Ball Park", "time" => "1:10PM"},
                "homeScore" => "8",
                "inningSummary" => %{"inning" => [%{"@number" => "1",
                    "awayScore" => "3", "homeScore" => "4"},
                %{"@number" => "2", "awayScore" => "4", "homeScore" => "1"},
                %{"@number" => "3", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "4", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "5", "awayScore" => "1", "homeScore" => "0"},
                %{"@number" => "6", "awayScore" => "3", "homeScore" => "0"},
                %{"@number" => "7", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "8", "awayScore" => "0", "homeScore" => "1"},
                %{"@number" => "9", "awayScore" => "1", "homeScore" => "2"}]},
                "isCompleted" => "true", "isInProgress" => "false",
                "isUnplayed" => "false"},
            %{"awayScore" => "5",
                "game" => %{"ID" => "39059",
                "awayTeam" => %{"Abbreviation" => "DET", "City" => "Detroit",
                    "ID" => "117", "Name" => "Tigers"}, "date" => "2017-04-22",
                "homeTeam" => %{"Abbreviation" => "MIN", "City" => "Minnesota",
                    "ID" => "120", "Name" => "Twins"}, "location" => "Target Field",
                "time" => "2:10PM"}, "homeScore" => "4",
                "inningSummary" => %{"inning" => [%{"@number" => "1",
                    "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "2", "awayScore" => "1", "homeScore" => "2"},
                %{"@number" => "3", "awayScore" => "2", "homeScore" => "0"},
                %{"@number" => "4", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "5", "awayScore" => "0", "homeScore" => "1"},
                %{"@number" => "6", "awayScore" => "2", "homeScore" => "0"},
                %{"@number" => "7", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "8", "awayScore" => "0", "homeScore" => "0"},
                %{"@number" => "9", "awayScore" => "0", "homeScore" => "1"}]},
                "isCompleted" => "true", "isInProgress" => "false",
                "isUnplayed" => "false"},
      iex(4)> game = p["scoreboard"]["gameScore"] |> hd
      iex(11)> game["game"]["awayTeam"]["Name"] <> " " <>  game["awayScore"] <> "-" <> " " <> game["game"]["homeTeam"]["Name"] <> " " <>  game["homeScore"]
      "Cubs 12- Reds 8"
  """
  def scoreboard(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/scoreboard.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """

  ## Examples:

    iex(26)> {s, p} = MySportsFeeds.MLB.roster_players("20170422")
    {:ok,
    %{"rosterplayers" => %{"lastUpdatedOn" => nil,
        "playerentry" => [%{"player" => %{"Age" => "31",
            "BirthCity" => "La Romana", "BirthCountry" => "DominicanRepublic",
            "BirthDate" => "1985-12-17", "FirstName" => "Fernando",
            "Height" => "6'1\"", "ID" => "10277", "IsRookie" => "false",
            "JerseyNumber" => "58", "LastName" => "Abad", "Position" => "P",
            "Weight" => "220"},
            "team" => %{"Abbreviation" => "BOS", "City" => "Boston", "ID" => "113",
            "Name" => "Red Sox"}},
        %{"player" => %{"Age" => "21", "BirthCity" => "Guayubin",
            "BirthCountry" => "DominicanRepublic", "BirthDate" => "1995-09-26",
            "FirstName" => "Albert", "Height" => "6'2\"", "ID" => "12370",
            "IsRookie" => "true", "LastName" => "Abreu", "Position" => "P",
            "Weight" => "175"},
            "team" => %{"Abbreviation" => "NYY", "City" => "New York",
            "ID" => "114", "Name" => "Yankees"}},
  """
  def roster_players(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/roster_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  daily_dfs

  ## Examples:

    iex(27)> {s, p} = MySportsFeeds.MLB.daily_dfs("2017-04-22")
    {:ok,
    %{"dailydfs" => %{"dfsEntries" => [%{"dfsRows" => [%{"game" => %{"awayTeam" => %{"Abbreviation" => "WAS",
               "City" => "Washington", "ID" => "126", "Name" => "Nationals"},
             "date" => "2017-04-22",
             "homeTeam" => %{"Abbreviation" => "NYM", "City" => "New York",
               "ID" => "127", "Name" => "Mets"}, "id" => "39787",
             "time" => "4:05PM"},
           "player" => %{"FirstName" => "Max", "ID" => "11042",
             "LastName" => "Scherzer", "Position" => "P",
             "dfsSourceId" => "326473"}, "salary" => "14000",
           "team" => %{"Abbreviation" => "WAS", "City" => "Washington",
             "ID" => "126", "Name" => "Nationals"}},
         %{"game" => %{"awayTeam" => %{"Abbreviation" => "LAD",
               "City" => "Los Angeles", "ID" => "137", "Name" => "Dodgers"},
             "date" => "2017-04-22",
             "homeTeam" => %{"Abbreviation" => "ARI", "City" => "Arizona",
               "ID" => "140", "Name" => "Diamondbacks"}, "id" => "37805",
             "time" => "8:10PM"},
           "player" => %{"FirstName" => "Clayton", "ID" => "10573",
             "LastName" => "Kershaw", "Position" => "P",
             "dfsSourceId" => "326468"}, "salary" => "12800",
           "team" => %{"Abbreviation" => "LAD", "City" => "Los Angeles",
             "ID" => "137", "Name" => "Dodgers"}},
         %{"fantasyPoints" => "5.00",
           "game" => %{"awayTeam" => %{"Abbreviation" => "CLE",
               "City" => "Cleveland", "ID" => "116", "Name" => "Indians"},
             "date" => "2017-04-22",
             "homeTeam" => %{"Abbreviation" => "CWS", "City" => "Chicago",
               "ID" => "119", "Name" => "White Sox"}, "id" => "38687",
             "time" => "7:10PM"},
           "player" => %{"FirstName" => "Corey", "ID" => "10369",
             "LastName" => "Kluber", "Position" => "P",
             "dfsSourceId" => "390385"}, "salary" => "12100",
           "team" => %{"Abbreviation" => "CLE", "City" => "Cleveland",
             "ID" => "116", "Name" => "Indians"}},

    iex(50)> p["dailydfs"]["dfsEntries"] |> tl |> hd |> Map.get("dfsType")
    "FanDuel"
    iex(51)> p["dailydfs"]["dfsEntries"] |> hd |> Map.get("dfsType")
    "DraftKings"

    iex(39)> dfs = p["dailydfs"]["dfsEntries"] |> hd
    iex(39)> Enum.each(dfs["dfsRows"], fn(row) -> IO.puts row["player"]["FirstName"] <> " " <> row["player"]["LastName"] <> " - " <> row["salary"] end)
    Max Scherzer - 14000
    Clayton Kershaw - 12800
    Corey Kluber - 12100
    Noah Syndergaard - 11700
    Stephen Strasburg - 11500
    Carlos Carrasco - 10900
    Jake Arrieta - 10600
    Justin Verlander - 10500
    Lance McCullers Jr - 10500
    Chris Sale - 10400
    Michael Pineda - 10100
    Danny Salazar - 10000
    Chris Archer - 9900
  """
  def daily_dfs(date, season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/daily_dfs.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  current_season: Grabs season with some details.

  iex(1)> MySportsFeeds.MLB.current_season("2017-01-03")
  {:ok,
  %{"currentseason" => %{"lastUpdatedOn" => nil,
      "season" => [%{"details" => %{"endDate" => "2017-04-12",
            "intervalType" => "regular", "name" => "2016-2017 Regular",
            "slug" => "2016-2017-regular", "startDate" => "2016-10-25"},
          "supportedPlayerStats" => %{"playerStat" => [%{"abbreviation" => "2PA",
              "category" => "Field Goals", "name" => "2Pt Field Goal Attempts"},
  """
  def current_season(date, opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{
      force: "false",
      fordate: String.replace(date, "-", ""),
    }
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/current_season.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  active_players: fetch all active players regardless if they are on a roster or not.

  ## Examples:

      iex(19)> {s, p} = MySportsFeeds.MLB.active_players
      {:ok,
        %{"activeplayers" => %{"lastUpdatedOn" => "2017-04-22 7:25:01 PM",
            "playerentry" => [%{"player" => %{"Age" => "31",
                "BirthCity" => "La Romana", "BirthCountry" => "DominicanRepublic",
                "BirthDate" => "1985-12-17", "FirstName" => "Fernando",
                "Height" => "6'1\"", "ID" => "10277", "IsRookie" => "false",
                "JerseyNumber" => "58", "LastName" => "Abad", "Position" => "P",
                "Weight" => "220"},
                "team" => %{"Abbreviation" => "BOS", "City" => "Boston", "ID" => "113",
                "Name" => "Red Sox"}},
  """
  def active_players(season \\ "latest", opts \\ %{}, ttl_seconds \\ 86_400) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/active_players.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end


  @doc """
  overall_team_standings

  ## Examples:

      iex(21)> {s, p} = MySportsFeeds.MLB.overall_team_standings
      {:ok,
      %{"overallteamstandings" => %{"lastUpdatedOn" => "2017-04-07 2:22:32 AM",
          "teamstandingsentry" => [%{"rank" => "1",
              "stats" => %{"FoulFlag1PerGame" => %{"#text" => "0.0",
                  "@abbreviation" => "FF1/G", "@category" => "Miscellaneous"},
                "FgAttPerGame" => %{"#text" => "87.0", "@abbreviation" => "FGA/G",
                  "@category" => "Field Goals"},
                "Losses" => %{"#text" => "14", "@abbreviation" => "L",
                  "@category" => "Standings"},
                "Fg3PtMadePerGame" => %{"#text" => "12.0", "@abbreviation" => "3PM/G",
                  "@category" => "Field Goals"},
                "FgAtt" => %{"#text" => "6874", "@abbreviation" => "FGA",
                  "@category" => "Field Goals"},
                "Fg2PtAttPerGame" => %{"#text" => "55.8", "@abbreviation" => "2PA/G",
                  "@category" => "Field Goals"},
                "Fg3PtAtt" => %{"#text" => "2467", "@abbreviation" => "3PA",
                  "@category" => "Field Goals"},

  """
  def overall_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    # teamstats={team-stats}&

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/overall_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  def conference_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/conference_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  def division_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/division_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  playoff_team_standings:

  Seems the same as conference_team_standings.
  """
  def playoff_team_standings(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/playoff_team_standings.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  player_injuries


  ## Examples:

    iex(34)> {s, p} = MySportsFeeds.MLB.player_injuries
    {:ok,
    %{"playerinjuries" => %{"lastUpdatedOn" => "2017-04-07 8:58:32 AM",
        "playerentry" => [%{"injury" => "knee sprain (Out)",
            "player" => %{"Age" => "23", "BirthCity" => "Palma de Mallorca",
              "BirthCountry" => "Spain", "BirthDate" => "1993-08-01",
              "FirstName" => "Alex", "Height" => "6'6\"", "ID" => "10138",
              "IsRookie" => "true", "JerseyNumber" => "8", "LastName" => "Abrines",
              "Position" => "F", "Weight" => "190"},
            "team" => %{"Abbreviation" => "OKL", "City" => "Oklahoma City",
              "ID" => "96", "Name" => "Thunder"}},
  """
  def player_injuries(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/player_injuries.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

  @doc """
  latest_updates

  ## Examples:

      iex(37)> {s, p} = MySportsFeeds.MLB.latest_updates

      09:26:35.050 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/mlb/latest/latest_updates.json?force=false

      09:26:36.106 [info]  Got results...parsing
      {:ok,
      %{"latestupdates" => %{"feedentry" => [%{"feed" => %{"Abbreviation" => "CUMULATIVE_PLAYER_STATS",
              "Description" => "A list of player stats totals for all roster players, summarized by their latest team.",
              "Name" => "Cumulative Player Stats"},
            "lastUpdatedOn" => "2017-04-07 2:22:32 AM"},
          %{"feed" => %{"Abbreviation" => "FULL_GAME_SCHEDULE",
              "Description" => "A list of all games to be played for the entire season.",
              "Name" => "Full Game Schedule"},
            "lastUpdatedOn" => "2017-04-04 7:40:56 AM"},
          %{"feed" => %{"Abbreviation" => "DAILY_GAME_SCHEDULE",
              "Description" => "A list of games to be played for a given day.",
              "Name" => "Daily Game Schedule"},
            "forDate" => [%{"forDate" => "2016-10-25",
                "lastUpdatedOn" => "2016-10-25 8:29:16 AM"},
              %{"forDate" => "2016-10-29",
                "lastUpdatedOn" => "2016-10-29 11:05:52 AM"},
  """
  def latest_updates(season \\ "latest", opts \\ %{}, ttl_seconds \\ 3_600) do
    query_params = %{force: "false"}
    |> Map.merge(opts)
    |> URI.encode_query

    "https://www.mysportsfeeds.com/api/feed/pull/mlb/#{season}/latest_updates.json?#{query_params}"
    |> Request.cached_get(ttl_seconds)
  end

end
