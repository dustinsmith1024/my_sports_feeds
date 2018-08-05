defmodule MySportsFeeds.Entities.NFL.Position do
  alias MySportsFeeds.Entities.Team

  @derive [Poison.Encoder]
  defstruct [
    team: %Team{},
    yardLine: nil, # 35,
    point: nil, # null
  ]

end
