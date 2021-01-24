use Mix.Config

config :chat,
  ecto_repos: [Chat.Repo],
  bucket_name: System.get_env("AWS_BUCKET_NAME", "uploads")

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID", "local_access"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY", "local_access"),
  region: System.get_env("AWS_REGION", "local")

config :ex_aws, :s3,
  host: System.get_env("AWS_HOST", "127.0.0.1"),
  port: System.get_env("AWS_PORT", "9000"),
  region: System.get_env("AWS_REGION", "local"),
  scheme: System.get_env("AWS_SCHEME", "http://")

config :chat, ChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE", "secret_key"),
  render_errors: [view: ChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chat.PubSub,
  live_view: [signing_salt: "DeoHNfmY"],
  user: Chat.Users.User,
  repo: Chat.Repo

config :chat, :pow,
  user: Chat.Users.User,
  repo: Chat.Repo

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix_swagger, json_library: Jason

config :chat, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: ChatWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: ChatWeb.Endpoint
    ]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
