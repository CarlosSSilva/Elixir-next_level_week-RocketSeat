# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rocketpay,
  ecto_repos: [Rocketpay.Repo]

# Configures the endpoint
config :rocketpay, RocketpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sFS7SuS5yZulv9PzIPOGQKWASw6bnUmsI/Ey1qE08WIurNlcZiHyh1ccQvGI3juy",
  render_errors: [view: RocketpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocketpay.PubSub,
  live_view: [signing_salt: "gSqvnNGo"]

  config :rocketpay, Rocketpay.Repo, #config para password binary
 migration_primary_key: [type: :binary_id],
 migration_foreign_key: [type: :binary_id]

 config :rocketpay, :basic_auth, #auntentição / sendo usado uma variavel de ambiente para esconder credenciais
  username: "Carlos",
  password: "grande123" #para bloquear pastas e algumas rotas

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
