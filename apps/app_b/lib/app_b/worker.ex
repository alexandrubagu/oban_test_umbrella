defmodule AppB.Worker do
  use Oban.Worker, queue: :default

  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"number" => number}}) do
    say("I got #{number}")
    wait()

    create_job(number)

    :ok
  end

  defp say(message), do: Logger.info("[#{DateTime.utc_now()}][WorkerB] #{message}")
  defp wait(), do: 100..1000 |> Enum.shuffle() |> Enum.at(0) |> Process.sleep()

  defp create_job(number) do
    job = Oban.Job.new(%{"number" => number + 1}, queue: :default, worker: AppA.Worker)
    Oban.insert(AppB.Oban, job)
  end
end
