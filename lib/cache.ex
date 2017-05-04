defmodule MySportsFeeds.Cache.Supervisor do
  use Supervisor
  require Logger

  @moduledoc """
  Supervisor for the caching layer.
  """

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Cachex, [:app_cache, [], []])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
