defmodule MySportsFeeds.Entities.Team do
  # defmodule User do
  #   @enforce_keys [:name]
  #   defstruct name: nil, age: 10 + 11
  # end
  @derive [Poison.Encoder]
  defstruct [
    id: nil, # 62,
    city: nil, # "Dallas",
    name: nil, # "Cowboys",
    abbreviation: nil, # "DAL",
    homeVenue: nil, # {
      #id: nil, # 51,
      #name: nil, # "AT&T Stadium"
    #}
  ]
end