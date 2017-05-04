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
    MySportsFeeds.Cache.Supervisor.start_link
  end
end
