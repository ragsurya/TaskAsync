defmodule HeartbeatCollector.Repo do
  use Ecto.Repo,
    otp_app: :hb_collector,
    adapter: Ecto.Adapters.Postgres
end
