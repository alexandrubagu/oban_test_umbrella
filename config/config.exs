# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :persistence,
  ecto_repos: [Persistence.Repo]

config :app_a, Oban,
  name: AppA.Oban,
  repo: Persistence.Repo,
  queues: [default: 10]

config :app_b, Oban,
  name: AppB.Oban,
  repo: Persistence.Repo,
  queues: [default: 10]

import_config "#{config_env()}.exs"
