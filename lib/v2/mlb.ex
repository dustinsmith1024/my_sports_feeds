defmodule MSF.MLB do
  @moduledoc """
  My Sports Feeds MLB Feeds
  """
  alias MSF

  # team={list-of-teams} (filter teams)
  # date={date-range} (filter on dates) -> 20170427 or 'today', or 'yesterday
  # status={list-of-game-statuses} (filter game statuses)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  # iex(3)> MSF.MLB.games([season: "latest", team: "gsw,bos"])
  def games(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/games.json", query: params)
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
  def season_dfs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/dfs.json", query: params)
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
  # iex(7)> MSF.MLB.daily_dfs([date: "20190114"])
  def daily_dfs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/mlb/#{season}/date/#{date}/dfs.json", query: params2)
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
  def player_gamelogs(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/player_gamelogs.json", query: params)
  end

  # teamstats={list-of-team-stats} (filter team stats)
  # playerstats={list-of-player-stats} (filter player stats)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def boxscore(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/games/#{game}/boxscore.json", query: params)
  end

  # playtype={list-of-play-types} (filter play-by-play types)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def playbyplay(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/games/#{game}/playbyplay.json", query: params)
  end

  # position={list-of-positions} (filter player positions)
  # lineuptype={lineup-type} (filter lineup type)
  # force={force-if-not-modified} (force content)
  def lineup(game, query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/games/#{game}/lineup.json", query: params)
  end

  # date={date} (specify a date)
  # force={force-if-not-modified} (force content)
  def current_season(query \\ []) do
    MSF.get("/mlb/current_season.json", query: query)
  end

  # player={list-of-players} (filter players)
  # team={list-of-teams} (filter teams)
  # position={list-of-positions} (filter player positions)
  # sort={sort-specifier} (sort the feed's content)
  # offset={offset-specifier} (filter results starting at the given offset)
  # limit={limit-specifier} (limit the maximum # of results)
  # force={force-if-not-modified} (force content)
  def injuries(query \\ []) do
    MSF.get("/mlb/injuries.json", query: query)
  end

  # force={force-if-not-modified} (force content)
  def latest_updates(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/latest_updates.json", query: params)
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
    MSF.get("/mlb/#{season}/team_stats_totals.json", query: params)
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
    MSF.get("/mlb/#{season}/player_stats_totals.json", query: params)
  end

  # team={list-of-teams} (filter teams)
  # force={force-if-not-modified} (force content)
  def venues(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/venues.json", query: params)
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
  # iex(5)> MSF.MLB.players([position: "g", season: "latest", team: "bos", rosterstatus: "assigned-to-roster"])
  def players(query \\ []) do
    MSF.get("/mlb/players.json", query: query)
  end

  # date={date} (specify a date)
  # team={list-of-teams} (filter teams)
  # stats={list-of-stats} (filter stats)
  # force={force-if-not-modified} (force content)
  def standings(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/standings.json", query: params)
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
  # iex(3)> MSF.MLB.player_stats_total([season: "latest", player: "kevin-durant"])
  # iex(8)> MSF.MLB.player_stats_totals([position: "g", season: "2018-regular", team: "gsw"])
  def player_stats_total(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    MSF.get("/mlb/#{season}/player_stats_totals.json", query: params)
  end


  # 20190122
  # https://api.mysportsfeeds.com/v2.0/pull/mlb/2018-2019-regular/odds_gamelines.json?team=bos
  # requires a team query param
  def odds_gamelines(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    # TODO: add case to auto handle the daily games
    MSF.get("/mlb/#{season}/odds_gamelines.json", query: params)
  end

  # requires a date
  def daily_odds_gamelines(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/mlb/#{season}/date/#{date}/odds_gamelines.json", query: params2)
  end

  # requires a date
  def daily_odds_futures(query \\ []) do
    {season, params} = Keyword.pop(query, :season, "latest")
    {date, params2} = Keyword.pop(params, :date, "today")
    MSF.get("/mlb/#{season}/date/#{date}/odds_futures.json", query: params2)
  end
end
