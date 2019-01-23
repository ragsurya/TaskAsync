defmodule HeartbeatCollector.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  import Supervisor.Spec, warn: false

  def start(_type, _args) do

    # Supervisor.start_link([worker(HeartbeatCollector.HeartbeatUpdater, [])],
    # [strategy: :one_for_one, name: HeartbeatCollector.Supervisor])
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      HeartbeatCollector.Repo,
      # Start the endpoint when the application starts
      HeartbeatCollectorWeb.Endpoint,
      HeartbeatCollector.HeartbeatUpdater
      # Starts a worker by calling: HeartbeatCollector.Worker.start_link(arg)
      # {HeartbeatCollector.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HeartbeatCollector.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HeartbeatCollectorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
