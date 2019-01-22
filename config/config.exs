# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hb_collector,
  namespace: HeartbeatCollector,
  ecto_repos: [HeartbeatCollector.Repo]

# Configures the endpoint
config :hb_collector, HeartbeatCollectorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DAQXBjZ0HFXd0kqWSesN4nm1nwGcK/Eulf9RtoPGkOns4GXMk7UccaxAGak+tlNC",
  render_errors: [view: HeartbeatCollectorWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HeartbeatCollector.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
