defmodule MSF.NFL do
  @moduledoc """
  My Sports Feeds NFL Feeds
  """

  def user_repos(client, login) do
    # pass `client` argument to `get` function
    Tesla.get(client, "/user/" <> login <> "/repos")
  end

  def issues(client) do
    Tesla.get(client, "/issues")
  end

  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates) -> 20170427 or 'today', or 'yesterday
  # status={list-of-game-statuses} (filter game statuses)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(3)> MSF.games(c, [season: "latest", team: "kc,ne"])
  def games(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/games.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # status={list-of-game-statuses} (filter game statuses)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def weekly_games(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {week, params2} = Keyword.pop(params, :week, 1) # dont default this?
    Tesla.get(client, "/nfl/#{season}/week/#{week}/games.json", query: params2)
  end

  # team={list-of-teams} (filter teams)
  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # country={list-of-countries} (filter player countries of birth)
  # dfstype={list-of-dfs-types} (filter DFS types) draftkings or fanduel
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def seasonal_dfs(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/dfs.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # country={list-of-countries} (filter player countries of birth)
  # dfstype={list-of-dfs-types} (filter DFS types)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(7)> MSF.NBA.daily_dfs(c, [date: "20190114"])
  def daily_dfs(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    Tesla.get(client, "/nfl/#{season}/date/#{date}/dfs.json", query: params2)
  end

  # team={list-of-teams} (filter teams)
  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # game={list-of-games} (filter on games)
  # date={date-range} (filter on dates) -> 20170427 or 'today', or 'yesterday'
  # stats={list-of-stats} (filter stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def player_gamelogs(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/player_gamelogs.json", query: params)
  end

  # teamstats={list-of-team-stats} (filter team stats)
  # playerstats={list-of-player-stats} (filter player stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def boxscore(client, game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/games/#{game}/boxscore.json", query: params)
  end

  # playtype={list-of-play-types} (filter play-by-play types)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def playbyplay(client, game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/games/#{game}/playbyplay.json", query: params)
  end

  # position={list-of-positions} (filter player positions)
  # lineuptype={lineup-type} (filter lineup type)
  # force={force-if-not-modified} (force content)
  def lineup(client, game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/games/#{game}/lineup.json", query: params)
  end

  # date={date} (specify a date)
  # force={force-if-not-modified} (force content)
  def current_season(client, query \\ []) do
    Tesla.get(client, "/nfl/current_season.json", query: query)
  end

  # player={list-of-players} (filter players)
  # team={list-of-teams} (filter teams)
  # position={list-of-positions} (filter player positions)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def injuries(client, query \\ []) do
    Tesla.get(client, "/nfl/injuries.json", query: query)
  end

  # force={force-if-not-modified} (force content)
  def latest_updates(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/latest_updates.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates)
  # stats={list-of-stats} (filter stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def team_stats_totals(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/team_stats_totals.json", query: params)
  end

  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # country={list-of-countries} (filter player countries of birth)
  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates)
  # stats={list-of-stats} (filter stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def player_stats_totals(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/player_stats_totals.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # force={force-if-not-modified} (force content)
  def venues(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/venues.json", query: params)
  end

  # season={season-identifier} (filter on a specific season)
  # date={date} (specify a date)
  # team={list-of-teams} (filter teams)
  # rosterstatus={list-of-roster-statuses} (filter roster statuses)
  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # country={list-of-countries} (filter player countries of birth)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(5)> MSF.players(c, [position: "qb", season: "latest", team: "kc", rosterstatus: "assigned-to-roster"])
  def players(client, query \\ []) do
    Tesla.get(client, "/nfl/players.json", query: query)
  end

  # date={date} (specify a date)
  # team={list-of-teams} (filter teams)
  # stats={list-of-stats} (filter stats)
  # force={force-if-not-modified} (force content)
  def standings(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/standings.json", query: params)
  end

  # player={list-of-players} (filter players)
  # position={list-of-positions} (filter player positions)
  # country={list-of-countries} (filter player countries of birth)
  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates)
  # stats={list-of-stats} (filter stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(3)> MSF.player_stats_total(c, [season: "latest", player: "tyreek-hill"])
  # iex(8)> MSF.player_stats_totals(c, [position: "qb", season: "2018-regular", team: "kc"])
  def player_stats_total(client, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    Tesla.get(client, "/nfl/#{season}/player_stats_totals.json", query: params)
  end

  # build dynamic client based on runtime arguments
  def client() do
    client(System.get_env("MY_SPORTS_FEEDS_TOKEN"))
  end

  def client(token) do
    # "https://api.mysportsfeeds.com/v2.0/pull/nfl/#{season}/player_stats_totals.json?#{query_params}"
    # "https://www.mysportsfeeds.com/api/feed/pull/nfl/#{season}/daily_player_stats.json?#{query_params}"
    middleware = [
      Tesla.Middleware.Logger,
      {Tesla.Middleware.BaseUrl, "https://api.mysportsfeeds.com/v2.0/pull"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Basic " <> token}]}
      # provide an options for this?
      # {Tesla.Middleware.Query, [force: "true"]},
    ]

    Tesla.client(middleware)
  end
end
