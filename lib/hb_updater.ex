
defmodule HeartbeatCollector.HeartbeatUpdater do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:poll_health_check, state) do
    # Do the work you desire here
    schedule_work()
    poll_health_check() # Reschedule once more
    {:noreply, state}
  end

  def poll_health_check do
    HTTPoison.get("/api/heartbeats")
    IO.puts "To the moon!"
  end

  defp schedule_work() do
    Process.send_after(self(), :poll_health_check, 10000) # In 2 secs
  end
end


