defmodule MySportsFeeds.Entities.Handedness do
  @derive [Poison.Encoder]
  defstruct [
    bats: nil, # "R"
    throws: nil # "L"
  ]
end