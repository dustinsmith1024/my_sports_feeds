defmodule MySportsFeeds.Entities.Stats.Fumbles do
  defstruct [
    fumbles: nil, # 1,
    fumLost: nil, # 1,
    fumForced: nil, # 0,
    fumOwnRec: nil, # 1,
    fumOppRec: nil, # 0,
    fumRecYds: nil, # 0,
    fumTotalRec: nil, # 1,
    fumTD: nil, # 0
  ]
end