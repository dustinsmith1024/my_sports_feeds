defmodule MySportsFeeds.Entities.FeedUpdates do
  alias MySportsFeeds.Entities.FeedUpdate
  alias MySportsFeeds.Entities.Games.Schedule

  @derive [Poison.Encoder]
  defstruct [
    # A list of players with stats
    lastUpdatedOn: nil,
    feedUpdates: [%FeedUpdate{}]
  ]

  # Started on this, but the old updates seem a little off
  # and not consistently there.
  # Going to just poll the other piece for now.
  def boxscores(%__MODULE__{feedUpdates: feedUpdates}) do
    boxScoreUpdate = Enum.find(feedUpdates, fn(update) ->
      update.feed.abbreviation == "GAME_BOXSCORE"
    end)

    IO.inspect boxScoreUpdate

    more = Enum.map(boxScoreUpdate.forGames, fn(game) ->
      IO.inspect game
      {Schedule.id(game.game), game.lastUpdatedOn}
    end)
    IO.inspect more
    more
  end


end
