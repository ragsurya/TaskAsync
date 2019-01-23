defmodule HeartbeatCollector do
  use Application
  @moduledoc """
  HeartbeatCollector keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      #worker(__MODULE__, [], function: :start_server),
      worker(HeartbeatCollector.HeartbeatUpdater, [])
    ]
    opts = [strategy: :one_for_one, name: HeartbeatCollector.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_server do
    {:ok, _} = Plug.Adapters.Cowboy.http HeartbeatCollectorWeb.Router, [acceptors: 2]
  end
end
