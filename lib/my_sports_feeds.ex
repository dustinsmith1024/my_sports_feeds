defmodule MySportsFeeds do
  use Application
  require Logger

  @moduledoc """
  Entry point for the MySportsFeeds application.
  Kicks off caching layer.
  """

  @doc """
  Starts the cache.
  """
  def start(_type, _args) do
    # MySportsFeeds.Cache.Supervisor.start_link
    import Supervisor.Spec, warn: false

    children = [
      # supervisor(Phoenix.PubSub.PG2, [MySportsFeeds.PubSub, []]),
      # supervisor(Phoenix.PubSub.PG2, [:my_sports_feeds, []]),
      supervisor(MySportsFeeds.Cache.Supervisor, []),
      # supervisor(MySportsFeeds.PubSub, ["games", [name: SportsPub]])
    ]

    opts = [strategy: :one_for_one, name: MySportsFeeds.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
