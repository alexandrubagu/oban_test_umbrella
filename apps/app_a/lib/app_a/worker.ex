defmodule AppA.Worker do
  use Oban.Worker, queue: :default

  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"number" => number}}) do
    say("I got #{number}")

    wait()

    maybe_create_job(number)

    :ok
  end

  defp say(message), do: Logger.info("[#{DateTime.utc_now()}][WorkerA] #{message}")
  defp wait(), do: 100..1000 |> Enum.shuffle() |> Enum.at(0) |> Process.sleep()

  defp maybe_create_job(number) when number < 100, do: create_job(number)
  defp maybe_create_job(_number), do: nil

  defp create_job(number) do
    job = Oban.Job.new(%{number: number + 1}, queue: :default, worker: AppB.Worker)
    Oban.insert(AppA.Oban, job)
  end
end
