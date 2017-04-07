defmodule MySportsFeeds.NBA do
  require Logger
  alias MySportsFeeds.Request

  @doc """
  daily_player_stats: Fetch NBA stats for a date.

  ## Examples

      # No new info
      iex(25)> {status, stats} = MySportsFeeds.basketball_stats("2017-03-01")
      {:ok, false}


      iex(25)> {status, stats} = MySportsFeeds.basketball_stats("2017-03-01")
      {:ok,
        %{ "dailyplayerstats" => %{"lastUpdatedOn" => "2017-03-02 2:14:55 AM",
           "playerstatsentry" => [
             %{
               "player" => %{
                  "FirstName" => "Quincy",
                  "ID" => "9466", "JerseyNumber" => "4", "LastName" => "Acy",
                  "Position" => "PF"
                },
               "stats" => %{
                 "FoulFlag1PerGame" => %{
                   "#text" => "0.0",
                   "@abbreviation" => "FF1/G",
                   "@category" => "Miscellaneous"
                 },
                 ...
                },
              "team" => %{
                "Abbreviation" => "BRO", "City" => "Brooklyn", "ID" => "84",
                "Name" => "Nets"
              }
            }
          ]
        }
      }

      iex(30)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("team")
      %{"Abbreviation" => "BRO", "City" => "Brooklyn", "ID" => "84", "Name" => "Nets"}
      iex(31)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("player")
      %{"FirstName" => "Quincy", "ID" => "9466", "JerseyNumber" => "4",
        "LastName" => "Acy", "Position" => "PF"}
      iex(32)> stats["dailyplayerstats"]["playerstatsentry"] |> hd |> Map.get("stats") |> Map.get("PtsPerGame")
      %{"#text" => "4.0", "@abbreviation" => "PTS/G", "@category" => "Offense"}
  """
  def daily_player_stats(date, opts \\ %{}) do
    options = Map.merge(opts, %{force: "false", season: "2016-2017"})
    # date format is "2016-11-04"
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{options.season}/daily_player_stats.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  cumulative_player_stats: Get all the players stats for the whole season.

  ## Examples

      iex(17)> {status, stats} = MySportsFeeds.NBA.cumulative_player_stats
      iex(16)> stats["cumulativeplayerstats"]["playerstatsentry"] |> hd
      %{"player" => %{"FirstName" => "Alex", "ID" => "10138", "JerseyNumber" => "8",
        "LastName" => "Abrines", "Position" => "F"},
      "stats" => %{"FoulFlag1PerGame" => %{"#text" => "0.0",
          "@abbreviation" => "FF1/G", "@category" => "Miscellaneous"},
        "FgAttPerGame" => %{"#text" => "4.7", "@abbreviation" => "FGA/G",
          "@category" => "Field Goals"},
        "Fg3PtMadePerGame" => %{"#text" => "1.3", "@abbreviation" => "3PM/G",
          "@category" => "Field Goals"},
          ...
      "team" => %{"Abbreviation" => "OKL", "City" => "Oklahoma City", "ID" => "96",
        "Name" => "Thunder"}}
  """
  def cumulative_player_stats(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"}) # add player_stats??
    # playerstats={player-stats}
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/cumulative_player_stats.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  full_game_schedule: gets the schedule for the season.

  iex(20)> {status, stats} = MySportsFeeds.NBA.full_game_schedule
  stats["fullgameschedule"]["gameentry"] |> hd
  """
  def full_game_schedule(season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/full_game_schedule.json?force=#{options.force}"


    Request.get(url)
    |> parse
  end

  @doc """
  daily_game_schedule: gets the schedule for a date.

  ## Examples:

      iex(21)> {status, stats} = MySportsFeeds.NBA.daily_game_schedule("2017-04-05")
      {:ok,
      %{"dailygameschedule" => %{"gameentry" => [%{"awayTeam" => %{"Abbreviation" => "MIA",
                "City" => "Miami", "ID" => "92", "Name" => "Heat"},
              "date" => "2017-04-05",
              "homeTeam" => %{"Abbreviation" => "CHA", "City" => "Charlotte",
  """
  def daily_game_schedule(date, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    # date format is "2016-11-04"
    # TODO: pull season from date?
    stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/daily_game_schedule.json?fordate=#{stripped_date}&force=#{options.force}"


    Request.get(url)
    |> parse
  end


  @doc """


  (game date as YYYYMMDD) + "-" +
  (away team abbreviation) + "-" +
  (home team abbreviation)

  ## Examples:

      iex(5)> {s, p} = MySportsFeeds.NBA.game_playbyplay("20170405-GSW-PHX")
      iex(5)> p["gameplaybyplay"]["plays"]["play"] |> hd
      %{"jumpBall" => %{"awayPlayer" => %{"FirstName" => "Zaza", "ID" => "9183",
        "JerseyNumber" => "27", "LastName" => "Pachulia", "Position" => "C"},
      "homePlayer" => %{"FirstName" => "Alex", "ID" => "9431",
        "JerseyNumber" => "21", "LastName" => "Len", "Position" => "C"},
      "wonBy" => "HOME"}, "quarter" => "1", "time" => "0:00"}
  """
  def game_play_by_play(game, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    # date format is "2016-11-04"
    # TODO: pull season from date?
    # stripped_date = String.replace(date, "-", "")
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/game_playbyplay.json?gameid=#{game}&force=#{options.force}"


    Request.get(url)
    |> parse
  end


  @doc """
  game_boxscore: Box Score for the game. Includes all scoring plays.

  ## Examples:


      iex(1)> {s, p} = MySportsFeeds.NBA.game_boxscore("20170405-GSW-PHX")

      17:29:59.332 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nba/latest/game_boxscore.json?gameid=20170405-GSW-PHX&force=false

      17:29:59.945 [info]  Got results...parsing
      {:ok,
      %{"gameboxscore" => %{"awayTeam" => %{"awayPlayers" => %{"playerEntry" => [%{"player" => %{"FirstName" => "Matt",
                    "ID" => "9298", "LastName" => "Barnes", "Position" => "SF"},
                  "stats" => %{"FoulFlag1PerGame" => %{"#text" => "0.0",
                      "@abbreviation" => "FF1/G", "@category" => "Miscellaneous"},
                    "FgAttPerGame" => %{"#text" => "9.0", "@abbreviation" => "FGA/G",
                      "@category" => "Field Goals"},
  """
  def game_boxscore(game, season \\ "latest", opts \\ %{}) do
    options = Map.merge(opts, %{force: "false"})
    # date format is "2016-11-04"
    # TODO: pull season from date?
    # stripped_date = String.replace(date, "-", "")
    # &teamstats={team-stats}&playerstats={player-stats}
    url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/game_boxscore.json?gameid=#{game}&force=#{options.force}"
    # url = "https://www.mysportsfeeds.com/api/feed/pull/nba/#{season}/game_playbyplay.json?gameid=#{game}&force=#{options.force}"


    Request.get(url)
    |> parse
  end


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
