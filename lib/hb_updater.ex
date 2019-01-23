
defmodule HeartbeatCollector.HeartbeatUpdater do
  use GenServer

  def start_link(_param) do
    GenServer.start_link(__MODULE__, [])
  end
  
  def poll_health_check do
    {:ok, response } = HTTPoison.get("http://localhost:4000/api/heartbeats")
    IO.inspect response
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:poll_health_check, state) do
    schedule_work()
    poll_health_check() # Reschedule once more
    {:noreply, state}
  end


  defp schedule_work() do
    Process.send_after(self(), :poll_health_check, 5000) # In 2 secs
  end
end


