defmodule MeshRelay.UserChannel do
  use Phoenix.Channel, :channel
  alias PhoenixChat.Presence
  require Logger

  defp uids_present(to_uid, from_uid) do
    to_uid && from_uid
  end

  defp has_valid_payload(payload) do
    uid = payload["to"]
    message = payload["message"]

    uid && message
  end

  # uid is the member's channel that
  # he/she receives their messages on.
  # no messages not intended to be received by
  # this member should be sent on this channel / subtopic
  #
  # socket.assigns.uid is the uid from the connect
  def join("user:" <> uid, _params, socket) do
    has_uids = uids_present(uid, socket.assigns.uid)

    if has_uids do
      send(self, :after_join)
      # Logger.debug Presence.list(socket)
      {:ok, socket}
    else
      # kick him out he is not allowed here
      {:error,
        %{reason: "in order to receive messages, you must join a channel using your own uid"},
        socket
      }
    end
  end

  def handle_in("chat", incoming_payload, socket) do
    if has_valid_payload(incoming_payload) do
      from_uid = socket.assigns.uid
      uid = incoming_payload["to"]
      message = incoming_payload["message"]
      topic = "user:#{uid}"
      payload = %{uid: from_uid, message: message}

      MeshRelay.Endpoint.broadcast(topic, "chat", payload)
      # broadcast! socket, "chat", payload

      {:reply, :ok, socket}
    else
      {:reply,
        {:error,
          %{
            reason: "please format your message: { \"to\": \"uidstring\", \"message\": \"encrypted message\" }",
            data: incoming_payload
          }},
        socket
      }
    end
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.uid, %{
      online_at: inspect(System.system_time(:milli_seconds))
    })

    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def is_member_online? do
    #  Presence.list(socket)
  end

end
