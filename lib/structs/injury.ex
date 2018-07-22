defmodule MySportsFeeds.Entities.Injury do
  @derive [Poison.Encoder]
  defstruct [
    description: nil, #"left ankle contusion",
    playingProbability: nil, # "PROBABLE"
  ]
end
