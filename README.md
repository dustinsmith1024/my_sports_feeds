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

## Running

You will need an account with My Sports Feeds, then place your login:password in the `MY_SPORTS_FEEDS_TOKEN` environments variable. 

```
▶ MY_SPORTS_FEEDS_TOKEN="ZHVzdGluc21pdGgxMDI0OkR1JHRpbjEwMjQ=" iex -S mix

# Make API call
iex(1)> MySportsFeeds.NFL.daily_player_stats("2016-09-11")

21:04:28.071 [info]  Go for URL: https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_player_stats.json?force=true&fordate=20160911&season=2016-2017-regular

21:05:12.620 [info]  Got results...parsing
{:ok,
 %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-04-30 10:05:05 PM",
     "playerstatsentry" => [%{"player" => %{"FirstName" => "Jared",
          "ID" => "6923", "JerseyNumber" => "84", "LastName" => "Abbrederis",
  ....

# View cached keys with Cachex API
iex(3)> Cachex.keys(:app_cache)
{:ok,
 ["https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_player_stats.json?&fordate=20160911&season=2016-2017-regular"]}

# If you run the same command again, it should return right away.
iex(4)> MySportsFeeds.NFL.daily_player_stats("2016-09-11")
{:ok,
 %{"dailyplayerstats" => %{"lastUpdatedOn" => "2017-04-30 10:05:05 PM",
     "playerstatsentry" => [%{"player" => %{"FirstName" => "Jared",

...

# Force a API update with %{force: true}
iex(5)> MySportsFeeds.NFL.daily_player_stats("2016-09-11", %{force: true})


```