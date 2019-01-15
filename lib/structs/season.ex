defmodule MySportsFeeds.Entities.Season do
  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    name: nil, #"2017 Regular",
    slug: nil, # "2017-regular",
    startDate: nil, # "2017-09-08Z",
    endDate: nil, # "2017-12-31Z",
    seasonInterval: nil, # "REGULAR",
    supportedTeamStats: [], # TODO
    supportedPlayerStats: [], # TODO
  ]
end
