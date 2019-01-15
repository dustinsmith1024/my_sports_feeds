defmodule MySportsFeeds.Entities.Games.Schedule do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Venue

  @derive [Poison.Encoder]
  defstruct [
      id: nil, # 45944,
      week: nil, # 1,
      startTime: nil, # "2018-09-07T00:20:00.000Z",
      awayTeam: %Team{},
      homeTeam: %Team{},
      venue: %Venue{},
      venueAllegiance: nil, # "HOME",
      scheduleStatus: nil, # "NORMAL",
      originalStartTime: nil, # null,
      delayedOrPostponedReason: nil, # null,
      playedStatus: nil, # "UNPLAYED"
      attendance: nil,
  ]

  def game_name(%MySportsFeeds.Entities.Games.Schedule{} = game) do
    "#{game.awayTeam.abbreviation}-#{game.homeTeam.abbreviation}"
  end

  # (game date as YYYYMMDD) + "-" +
  # (away team abbreviation) + "-" +
  # (home team abbreviation)
  def id(%__MODULE__{} = game) do
    # IO.inspect(game)
    IO.inspect game
    date = String.split(game.schedule.startTime, "T")
    |> hd
    |> String.replace("-", "")

    awayTeam = game.schedule.awayTeam.abbreviation
    homeTeam = game.schedule.homeTeam.abbreviation

    "#{date}-#{awayTeam}-#{homeTeam}"
  end
end