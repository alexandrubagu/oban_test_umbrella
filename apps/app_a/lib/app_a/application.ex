defmodule AppA.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Oban, Application.fetch_env!(:app_a, Oban)}
    ]

    opts = [strategy: :one_for_one, name: AppA.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # AppA.Application.start 1
  def start(number) do
    job = AppA.Worker.new(%{number: number, callback_worker: AppA.Worker})
    Oban.insert(AppA.Oban, job)
  end
end
