defmodule MySportsFeeds.Entities.TeamVenue do
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Venue
  @derive [Poison.Encoder]
  defstruct [
    homeTeam: %Team{},
    venue: %Venue{},
  ]
end
