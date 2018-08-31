defmodule MySportsFeeds.Entities.Venues do
  alias MySportsFeeds.Entities.TeamVenue

  @derive [Poison.Encoder]
  defstruct [
    lastUpdatedOn: nil,
    venues: [%TeamVenue{}],
  ]
end
