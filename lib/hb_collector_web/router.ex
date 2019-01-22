defmodule HeartbeatCollectorWeb.Router do
  use HeartbeatCollectorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HeartbeatCollectorWeb do
    pipe_through :api

    get "/heartbeats", HeartbeatFetcher, :index
  end
end
