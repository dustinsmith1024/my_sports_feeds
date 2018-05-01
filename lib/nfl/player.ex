defmodule MySportsFeeds.NFL.Player do
  @derive [Poison.Encoder]
  defstruct [
    :ID,
    :LastName,
    :FirstName,
    :JerseyNumber,
    :Position,
    :Height,
    :Weight,
    :BirthDate,
    :Age,
    :BirthCity,
    :BirthCountry,
    :IsRookie,
  ]
end