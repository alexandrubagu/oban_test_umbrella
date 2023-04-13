defmodule Persistence.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Persistence.Repo
    ]

    opts = [strategy: :one_for_one, name: Persistence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
