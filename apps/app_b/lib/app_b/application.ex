defmodule AppB.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Oban, Application.fetch_env!(:app_b, Oban)}
    ]

    opts = [strategy: :one_for_one, name: AppB.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
