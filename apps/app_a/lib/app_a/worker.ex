defmodule AppA.Worker do
  use Oban.Worker, queue: :default

  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"number" => number}}) do
    say("I got #{number}")

    wait()

    :ok
  end

  defp say(message), do: Logger.info("[#{DateTime.utc_now()}][WorkerA] #{message}")
  defp wait(), do: Process.sleep(500)

  defp maybe_create_job(number) when number < 100, do: create_job(number)
  defp maybe_create_job(number), do: nil

  defp create_job(number) do
    job = AppB.Worker.new(%{number: number + 1}, queue: :default, worker: AppB.Worker)
    Oban.insert(AppA.Oban, job)
  end
end
