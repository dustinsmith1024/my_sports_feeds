defmodule MySportsFeeds.Cache.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      # worker(Cachex, [KV.Registry])
      # TODO: Do we want a fallback for this whole thing?
      # I don't really like this global.
      # Maybe make this on each function and have specific TTL's.
      worker(Cachex, [ :app_cache, [], [] ])
      # worker(Cachex, [ :app_cache, [fallback: &MySportsFeeds.Request.get/1], [] ])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
