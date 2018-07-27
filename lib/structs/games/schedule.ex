defmodule MySportsFeeds.Entities.Games.Schedule do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Venue

  @derive [Poison.Encoder]
  defstruct [
      atBats: nil, #0,
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
  ]

  def game_name(%MySportsFeeds.Entities.Games.Schedule{} = game) do
    "#{game.awayTeam.abbreviation}-#{game.homeTeam.abbreviation}"
  end
end