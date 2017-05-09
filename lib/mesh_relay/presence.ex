defmodule MeshRelay.Presence do
  use Phoenix.Presence, otp_app: :talkex, pubsub_server: MeshRelay.PubSub
end
