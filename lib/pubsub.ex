defmodule MySportsFeeds.PubSub do
  use GenServer
  alias Phoenix.PubSub
  require Logger

  @moduledoc """
  This is an exampe of how to subscribe and handle events.
  Not quite sure where we will publish from yet, but this 'works'

  Events:
    `game_scoreboard:id`
    `game_playbyplay:id`
  """

  def start_link(topic, otp_opts \\ []) when is_binary(topic) do
    GenServer.start_link(__MODULE__, topic, otp_opts)
  end

  # iex(8)> Phoenix.PubSub.broadcast :my_sports_feeds, "games", {:my_sports_feeds, %{id: 123, name: "Shane23"}}
  def broadcast(topic, message) do
    PubSub.broadcast(:my_sports_feeds, topic, {:my_sports_feeds, message})
  end

  #  MySportsFeeds.PubSub.messages_received(SportsPub)
  def messages_received(pid) do
    GenServer.call(pid, :messages_received)
  end

  def init(topic) do
    PubSub.subscribe(:my_sports_feeds, topic)
    {:ok, []}
  end

  def handle_call(:messages_received, _from, messages_received) do
    IO.inspect messages_received
    {:reply, Enum.reverse(messages_received), messages_received}
  end

  def handle_info({:my_sports_feeds, msg}, messages_received) do
    IO.inspect msg
    {:noreply, [msg | messages_received]}
  end
end