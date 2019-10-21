defmodule MeshRelayWeb.StatsChannel do
  use Phoenix.Channel
  alias MeshRelay.Presence

  def join("stats", params, socket) do
    send(self(), :after_join)

    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    stats = %{
      connection_count:
        # connected_members is managed in user_channel
        # NOTE: somehow connected members doesn't include the
        #       "current socket"'s user.
        # NOTE: the client should add one
        Presence.list("connected_members")
        |> Map.keys
        |> length,
      relay: %{
        elixir: System.version()
      }
    }

    # Send message to the person connecting
    push(socket, "state", stats)
    # Send message to everyone else
    broadcast_from(socket, "state", stats)

    {:noreply, socket}
  end
end
