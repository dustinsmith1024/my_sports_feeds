defmodule MySportsFeeds do
  use Application
  require Logger

  @moduledoc """
  Documentation for MySportsFeeds.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MySportsFeeds.hello
      :world

  """
  def start(_type, _args) do
    MySportsFeeds.Cache.Supervisor.start_link
  end
end
