defmodule HeartbeatCollector do
  use Application
  import Supervisor.Spec, warn: false
  @moduledoc """
  HeartbeatCollector keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def start(_type, _args) do

    Supervisor.start_link([worker(HeartbeatCollector.HeartbeatUpdater, [])],
                          [strategy: :one_for_one, name: HeartbeatCollector.Supervisor])

    # children = [
    #   worker(HeartbeatCollector.HeartbeatUpdater, [])
    # ]
    # opts = [strategy: :one_for_one, name: HeartbeatCollector.Supervisor]
    # Supervisor.start_link(children, opts)
  end
end
