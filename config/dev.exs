import Config

# Configure your database
config :persistence, Persistence.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "oban_test_umbrella",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
