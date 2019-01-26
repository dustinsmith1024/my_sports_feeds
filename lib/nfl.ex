defmodule MSF.NFL do
  @moduledoc """
  My Sports Feeds NFL Feeds
  """
  alias MSF

  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates) -> 20170427 or 'today', or 'yesterday
  # status={list-of-game-statuses} (filter game statuses)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(3)> MSF.games([season: "latest", team: "kc,ne"])
  def games(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/games.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # status={list-of-game-statuses} (filter game statuses)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def weekly_games(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {week, params2} = Keyword.pop(params, :week, 1) # dont default this?
    MSF.get("/nfl/#{season}/week/#{week}/games.json", query: params2)
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
  def seasonal_dfs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/dfs.json", query: params)
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
  # iex(7)> MSF.NBA.daily_dfs([date: "20190114"])
  def daily_dfs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/nfl/#{season}/date/#{date}/dfs.json", query: params2)
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
  # iex(15)> MSF.NFL.player_gamelogs(date: "20190120", player: "tyreek-hill", season: "2019-playoffs")
  def player_gamelogs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/player_gamelogs.json", query: params)
  end

  # teamstats={list-of-team-stats} (filter team stats)
  # playerstats={list-of-player-stats} (filter player stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def boxscore(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/games/#{game}/boxscore.json", query: params)
  end

  # playtype={list-of-play-types} (filter play-by-play types)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def playbyplay(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/games/#{game}/playbyplay.json", query: params)
  end

  # position={list-of-positions} (filter player positions)
  # lineuptype={lineup-type} (filter lineup type)
  # force={force-if-not-modified} (force content)
  def lineup(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/games/#{game}/lineup.json", query: params)
  end

  # date={date} (specify a date)
  # force={force-if-not-modified} (force content)
  def current_season(query \\ []) do
    MSF.get("/nfl/current_season.json", query: query)
  end

  # player={list-of-players} (filter players)
  # team={list-of-teams} (filter teams)
  # position={list-of-positions} (filter player positions)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def injuries(query \\ []) do
    MSF.get("/nfl/injuries.json", query: query)
  end

  # force={force-if-not-modified} (force content)
  def latest_updates(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/latest_updates.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates)
  # stats={list-of-stats} (filter stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def team_stats_totals(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/team_stats_totals.json", query: params)
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
  def player_stats_totals(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/player_stats_totals.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # force={force-if-not-modified} (force content)
  def venues(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/venues.json", query: params)
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
  # iex(5)> MSF.players([position: "qb", season: "latest", team: "kc", rosterstatus: "assigned-to-roster"])
  def players(query \\ []) do
    MSF.get("/nfl/players.json", query: query)
  end

  # date={date} (specify a date)
  # team={list-of-teams} (filter teams)
  # stats={list-of-stats} (filter stats)
  # force={force-if-not-modified} (force content)
  def standings(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/standings.json", query: params)
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
  # iex(3)> MSF.player_stats_total([season: "latest", player: "tyreek-hill"])
  # iex(8)> MSF.player_stats_totals([position: "qb", season: "2018-regular", team: "kc"])
  def player_stats_total(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/nfl/#{season}/player_stats_totals.json", query: params)
  end

  # 20190122
  # https://api.mysportsfeeds.com/v2.0/pull/nba/2018-2019-regular/odds_gamelines.json?team=bos
  # requires a team query param
  def odds_gamelines(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    # TODO: add case to auto handle the daily games
    MSF.get("/nfl/#{season}/odds_gamelines.json", query: params)
  end

  # requires a date
  # https://api.mysportsfeeds.com/v2.0/pull/nfl/2019-playoffs/date/20190120/odds_gamelines.json
  # https://api.mysportsfeeds.com/v2.0/pull/nfl/2019-playoffs/date/20190203/odds_gamelines.json
  def daily_odds_gamelines(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/nfl/#{season}/date/#{date}/odds_gamelines.json", query: params2)
  end

  # this wasnt working right when testing via postman
  def weekly_odds_gamelines(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {week, params2} = Keyword.pop(params, :week, 1)
    MSF.get("/nfl/#{season}/week/#{week}/odds_gamelines.json", query: params2)
  end

  # requires a date
  # https://api.mysportsfeeds.com/v2.0/pull/nfl/2019-playoffs/date/20190125/odds_futures.json
  def daily_odds_futures(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/nfl/#{season}/date/#{date}/odds_futures.json", query: params2)
  end
end
