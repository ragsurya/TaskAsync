defmodule HeartbeatCollectorWeb.HeartbeatFetcher  do
  use HeartbeatCollectorWeb, :controller
  # alias HeartbeatCollector.HeartBeats.ApiData

  def index(conn, _params) do
    serviceurls = Application.get_env(:hb_collector, :serviceurls, nil)
    #servicestatus = HeartbeatCollector.Repo.all(ApiData)
    json conn, HeartbeatCollectorWeb.HeartbeatFetcher.call_service(serviceurls)
  end

  def call_service(urls) do
      Enum.map(urls, fn(url) -> Task.async(fn -> get_status(url) end) end)
      |> Enum.map(fn(task) -> Task.await(task, 145000) end)
    end

  def get_status(url) do

    case HTTPoison.get(url) do
      {:ok, response } ->
        %{service: url, status: response.status_code, message: "Service is up and running"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        %{service: url, status: 500, message: reason}
    end
  end

end
