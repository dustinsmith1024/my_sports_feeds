# MySportsFeeds

A HTTP wrapper for the [My Sports Feeds API](https://www.mysportsfeeds.com/data-feeds/api-docs)

Provides a caching layer out of the box as well.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `my_sports_feeds` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:my_sports_feeds, "~> 0.1.0"}]
end
```

## Config

In you `config.exs` file put something like.  Match the environment variable you use when running your application.
```elixir
config :my_sports_feeds, token: System.get_env("MY_SPORTS_FEEDS_TOKEN")
```


## Running

You will need an account with My Sports Feeds, then place your login:password in the `MY_SPORTS_FEEDS_TOKEN` environments variable.

```elixir
▶ MY_SPORTS_FEEDS_TOKEN="<your_token>" iex -S mix
```

Make an API call

```elixir

iex(1)> MySportsFeeds.NFL.daily_player_stats("2016-09-11")

21:04:28.071 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_player_stats.json?force=true&fordate=20160911&season=2016-2017-regular

21:05:12.620 [info]  Got results...parsing
{:ok,
 %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-04-30 10:05:05 PM",
     "playerstatsentry" => [%{"player" => %{"FirstName" => "Jared",
          "ID" => "6923", "JerseyNumber" => "84", "LastName" => "Abbrederis",
  ....
```

Filtered results

```elixir
iex(3)> MySportsFeeds.NBA.daily_player_stats("2017-05-01", "latest",  %{player: "Lebron-James"})

22:56:18.708 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nba/latest/daily_player_stats.json?force=true&fordate=20170501&player=Lebron-James

22:56:19.024 [info]  Got results...parsing
{:ok,
 %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-05-02 3:44:02 PM",
     "playerstatsentry" => [%{"player" => %{"FirstName" => "LeBron",
          "ID" => "9158", "JerseyNumber" => "23", "LastName" => "James",
          "Position" => "SF"},
        "stats" => %{"FoulFlag1PerGame" => %{"#text" => "0.0",
            "@abbreviation" => "FF1/G", "@category" => "Miscellaneous"},
          "FgAttPerGame" => %{"#text" => "23.0", "@abbreviation" => "FGA/G",
            "@category" => "Field Goals"},
          "Fg3PtMadePerGame" => %{"#text" => "2.0", "@abbreviation" => "3PM/G",
            "@category" => "Field Goals"},
```

View cached keys with Cachex API

```elixir
iex(3)> Cachex.keys(:app_cache)
{:ok,
 ["https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_player_stats.json?&fordate=20160911&season=2016-2017-regular"]}
```

If you run the same command again, it should return right away.

```elixir
iex(4)> MySportsFeeds.NFL.daily_player_stats("2016-09-11")
{:ok,
 %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-04-30 10:05:05 PM",
     "playerstatsentry" => [%{"player" => %{"FirstName" => "Jared",

```

Force a API update with %{force: true}

```elixir
iex(5)> MySportsFeeds.NFL.daily_player_stats("2016-09-11", %{force: true})
```


# V2 Notes

https://api.mysportsfeeds.com/v2.0/pull/nba/2018-playoff/player_stats_totals.json

https://api.mysportsfeeds.com/v2.0/pull/nfl/2018-regular/venues.json

https://api.mysportsfeeds.com/v2.0/pull/nfl/2018-regular/week/2/games.json?forweek=1

https://api.mysportsfeeds.com/v2.0/pull/nfl/2018-regular/date/20180909/games.json

https://api.mysportsfeeds.com/v2.0/pull/nba/latest/dfs.json

Could take the latest updates
https://api.mysportsfeeds.com/v2.0/pull/nfl/2018-regular/latest_updates.json