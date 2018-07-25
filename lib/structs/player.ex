defmodule MySportsFeeds.Entities.Player do
  alias MySportsFeeds.Entities.Player
  alias MySportsFeeds.Entities.Handedness
  alias MySportsFeeds.Entities.Team
  alias MySportsFeeds.Entities.Injury

  @derive [Poison.Encoder]
  defstruct [
    # name: "John", age: 27
    id: nil, # 6914,
    firstName: nil, # "Aaron",
    lastName: nil, # "Rodgers",
    position: nil, # "QB",
    jerseyNumber: nil, # 12,
    # https://stackoverflow.com/questions/30855638/elixir-nested-json-parsing-to-structs
    # How to easily map these?
    currentTeam: %Team{},
    currentRosterStatus: nil, # "ROSTER",
    currentInjury: %Injury{}, # null,
    height: nil, # "6'2\"",
    weight: nil, # 225,
    birthDate: nil, # "1983-12-02Z",
    age: nil, # 34,
    birthCity: nil, # "Chico, CA",
    birthCountry: nil, # "USA",
    rookie: nil, # false,
    college: nil, # null,
    twitter: nil, # null,
    handedness: %Handedness{}, # Baseball only?
  ]

  # def decode(response) do
  #   Poison.decode(response, as: %Player{
  #     currentTeam: %Team{},
  #     handedness: %Handedness{},
  #     currentInjury: %Injury{},
  #   })
  # end
end