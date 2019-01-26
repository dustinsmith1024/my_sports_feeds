# My Sports Feeds

A HTTP wrapper for the [My Sports Feeds API](https://www.mysportsfeeds.com/data-feeds/api-docs)

Provides a caching layer out of the box as well.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `my_sports_feeds` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:my_sports_feeds, "~> 2.0.0"}]
end
```

## Running

You will need an account with My Sports Feeds, api key in the `MY_SPORTS_FEEDS_API_KEY` environments variable.

```elixir
▶ MY_SPORTS_FEEDS_API_KEY="<your_token>" iex -S mix
```

Or put it in config.

```elixir
config :msf, api_key: System.get_env("MY_SPORTS_FEEDS_API_KEY")
```


Make an API call

```elixir
iex(18)> {:ok, %{body: body}} = MSF.NFL.player_gamelogs(date: "20190120", player: "tyreek-hill", season: "2019-playoffs")

14:37:48.184 [info]  GET /nfl/2019-playoffs/player_gamelogs.json -> 200 (582.446 ms)

...

{:ok,
 %{
   body: %{
     "gamelogs" => [
       %{
         "game" => %{
           "awayTeamAbbreviation" => "NE",
           "homeTeamAbbreviation" => "KC",
           "id" => 51289,
           "startTime" => "2019-01-20T23:40:00.000Z",
           "week" => 20
         },
         "player" => %{
           "firstName" => "Tyreek",
           "id" => 9910,
           "jerseyNumber" => 10,
           "lastName" => "Hill",
           "position" => "WR"
         },
         "stats" => %{

iex(17)> hd(body["gamelogs"])["stats"]["receiving"]
%{
  "rec1stDowns" => 1,
  "rec20Plus" => 1,
  "rec40Plus" => 1,
  "recAverage" => 42.0,
  "recFumbles" => 0,
  "recLng" => 42,
  "recTD" => 0,
  "recYards" => 42,
  "receptions" => 1,
  "targets" => 3
}
```

NBA example:

```
iex(7)> {:ok, %{body: body}} = MSF.NBA.player_gamelogs(player: "kevin-durant", season: "2018-2019-regular")
14:49:41.035 [info]  GET /nba/2018-2019-regular/player_gamelogs.json -> 200 (5046.794 ms)
...
iex(6)> hd(body["gamelogs"])["stats"]["offense"]
%{"ast" => 6, "astPerGame" => 6.0, "pts" => 27, "ptsPerGame" => 27.0}
```

Force a API update by passing `force: true` to the options.

```elixir
iex(15)> MSF.NFL.player_gamelogs(date: "20190120", player: "tyreek-hill", season: "2019-playoffs", force: true)
```
