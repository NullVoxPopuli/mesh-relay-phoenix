defmodule MeshRelay.LobbyChannel do
  use Phoenix.Channel

  def join("lobby", _payload, socket) do
    if socket.assigns.uid do
    {:ok, socket}
  else
    # kick him out he is not allowed here
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("chat", payload, socket) do
    broadcast! socket, "chat", payload
    {:noreply, socket}
  end
end
