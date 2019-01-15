defmodule MySportsFeeds.Entities.FeedUpdate do
  alias MySportsFeeds.Entities.Feed
  alias MySportsFeeds.Entities.ForGame
  alias MySportsFeeds.Entities.ForDate

  @derive [Poison.Encoder]
  defstruct [
    feed: %Feed{},
    forGames: [%ForGame{}],
    forDates: [%ForDate{}],
    lastUpdatedOn: nil,
  ]
end
