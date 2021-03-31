# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :salve,
  ecto_repos: [Salve.Repo]

# Configures the endpoint
config :salve, SalveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1BkuS0RmvNbohm4GF1HXZN6ccWI7BQ1g/Fyp0HWq9pqDa2eQy9g+4BijPvPJsCfL",
  render_errors: [view: SalveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Salve.PubSub,
  live_view: [signing_salt: "Eu97GZOu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

## Setup Guardian Configurations
config :salve, Salve.Auth.Guardian,
  issuer: "salve",
  secret_key: "s5HygkxfUdPR7WrgkXjf242vauruEwfyQtRcgXhdTh7oMRh7nV8TOr3e3oFzyOvd"
