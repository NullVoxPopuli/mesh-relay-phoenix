# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
# config :mesh_relay, ecto_repos: [MeshRelay.Repo]

# Configures the endpoint
config :mesh_relay, MeshRelayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: nil,
  render_errors: [view: MeshRelay.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MeshRelay.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
