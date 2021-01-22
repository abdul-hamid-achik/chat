use Mix.Config

config :chat, Chat.Repo,
  username: "postgres",
  password: "postgres",
  database: "chat_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :chat, ChatWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

if System.get_env("GITHUB_ACTIONS") do
  config :chat, Chat.Repo,
    username: "postgres",
    password: "postgres"
end
