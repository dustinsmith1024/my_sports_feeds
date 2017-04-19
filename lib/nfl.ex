defmodule MySportsFeeds.NFL do
  require Logger
  alias MySportsFeeds.Request

  @doc """
  daily_player_stats: Fetch NBA stats for a date.

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
  def daily_player_stats(date, opts \\ %{}) do
    options = Map.merge(%{force: "false", season: "2016-2017-regular"}, opts)
    # date format is "2016-11-04"
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{options.season}/daily_player_stats.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
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
  def cumulative_player_stats(season \\ "latest", opts \\ %{}) do
    options = Map.merge(%{force: "false"}, opts) # add player_stats??
    # playerstats={player-stats}
    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/cumulative_player_stats.json?force=#{options.force}"


    Request.get(url)
    |> parse
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
  def full_game_schedule(season \\ "latest", opts \\ %{}) do
    options = Map.merge(%{force: "false"}, opts)

    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/full_game_schedule.json?force=#{options.force}"


    Request.get(url)
    |> parse
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
  def daily_game_schedule(date, season \\ "latest", opts \\ %{}) do
    options = Map.merge(%{force: "false"}, opts)
    # date format is "2016-11-04"
    # TODO: pull season from date?
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/daily_game_schedule.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
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
  def game_play_by_play(game, season \\ "latest", opts \\ %{}) do
    options = Map.merge(%{force: "false"}, opts)
    # date format is "2016-11-04"
    # TODO: pull season from date?
    # stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/game_playbyplay.json?gameid=#{game}&force=#{options.force}"


    Request.get(url)
    |> parse
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
  def game_boxscore(game, season \\ "latest", opts \\ %{}) do
    options = Map.merge(%{force: "false"}, opts)
    # date format is "2016-11-04"
    # TODO: pull season from date?
    # stripped_date = String.replace(date, "-", "")
    # &teamstats={team-stats}&playerstats={player-stats}
    url = "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/game_boxscore.json?gameid=#{game}&force=#{options.force}"


    Request.get(url)
    |> parse
  end

  # CONTINIUE HERE... done above

  @doc """
  scoreboard: get scores of all games on a day.

  ## Examples:

      iex(4)> {s, p} = MySportsFeeds.NBA.scoreboard("20170406")
      iex(4)> game = p["scoreboard"]["gameScore"] |> hd
      iex(11)> game["game"]["awayTeam"]["Name"] <> " " <>  game["awayScore"] <> "-" <> " " <> game["game"]["homeTeam"]["Name"] <> " " <>  game["homeScore"]
      "Bulls 102- 76ers 90"
  """
  def scoreboard(date, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/scoreboard.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """

  ## Examples:

    iex(18)> {s, p} = MySportsFeeds.NBA.roster_players("20170406")
    iex(17)> p["rosterplayers"]["playerentry"] |> List.last()
    %{"player" => %{"Age" => "20", "BirthDate" => "1997-03-17",
      "FirstName" => "Ivica", "Height" => "7'1\"", "ID" => "10169",
      "IsRookie" => "true", "JerseyNumber" => "40", "LastName" => "Zubac",
      "Position" => "C", "Weight" => "265"},
    "team" => %{"Abbreviation" => "LAL", "City" => "Los Angeles", "ID" => "105",
      "Name" => "Lakers"}}
  """
  def roster_players(date, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/roster_players.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  daily_dfs

  ## Examples:

    iex(41)> {s, p} = MySportsFeeds.NBA.daily_dfs("2017-04-06")
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
  def daily_dfs(date, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/daily_dfs.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  current_season: Grabs season with some details.

  iex(1)> MySportsFeeds.NBA.current_season("2017-01-03")
  {:ok,
  %{"currentseason" => %{"lastUpdatedOn" => nil,
      "season" => [%{"details" => %{"endDate" => "2017-04-12",
            "intervalType" => "regular", "name" => "2016-2017 Regular",
            "slug" => "2016-2017-regular", "startDate" => "2016-10-25"},
          "supportedPlayerStats" => %{"playerStat" => [%{"abbreviation" => "2PA",
              "category" => "Field Goals", "name" => "2Pt Field Goal Attempts"},
  """
  def current_season(date, opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/current_season.json?fordate=#{stripped_date}&force=#{options.force}"

    Request.get(url)
    |> parse
  end


  @doc """
  active_players: fetch all active players regardless if they are on a roster or not.

  ## Examples:

      iex(19)> {s, p} = MySportsFeeds.NBA.active_players
      {:ok,
      %{"activeplayers" => %{"lastUpdatedOn" => "2017-04-04 7:13:00 PM",
          "playerentry" => [%{"player" => %{"Age" => "23",
                "BirthCity" => "Palma de Mallorca", "BirthCountry" => "Spain",
                "BirthDate" => "1993-08-01", "FirstName" => "Alex",
                "Height" => "6'6\"", "ID" => "10138", "IsRookie" => "true",
                "JerseyNumber" => "8", "LastName" => "Abrines", "Position" => "F",
                "Weight" => "190"},
              "team" => %{"Abbreviation" => "OKL", "City" => "Oklahoma City",
                "ID" => "96", "Name" => "Thunder"}},
  """
  def active_players(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/active_players.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end


  @doc """
  overall_team_standings

  ## Examples:

      iex(21)> {s, p} = MySportsFeeds.NBA.overall_team_standings
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
  def overall_team_standings(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats={team-stats}&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/overall_team_standings.json?force=#{options.force}"
    # url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/active_players.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  def conference_team_standings(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats=none&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/conference_team_standings.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  def division_team_standings(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats=none&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/division_team_standings.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  playoff_team_standings:

  Seems the same as conference_team_standings.
  """
  def playoff_team_standings(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats=none&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/playoff_team_standings.json?force=#{options.force}"

    Request.get(url)
    |> parse
  end

  @doc """
  player_injuries


  ## Examples:

    iex(34)> {s, p} = MySportsFeeds.NBA.player_injuries
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
  def player_injuries(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats=none&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/player_injuries.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  latest_updates

  ## Examples:

      iex(37)> {s, p} = MySportsFeeds.NBA.latest_updates

      09:26:35.050 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nba/latest/latest_updates.json?force=false

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
  def latest_updates(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})

    # teamstats=none&
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/latest_updates.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  defp parse(response) do
     case response.status_code do
      304 ->
        Logger.info "No new info found"
        {:ok, false}
      200 ->
        # TODO: Make a formatted response handler here.
        # Can make an option to pass back 'raw' if wanted
        Logger.info "Got results...parsing"
        Request.parse(response)
      other ->
        IO.inspect response.headers
        {:error, other}
    end
  end
end
