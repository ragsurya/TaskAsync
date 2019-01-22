defmodule HeartbeatCollectorWeb.HeartbeatFetcherTest  do
  alias HeartbeatCollectorWeb.HeartbeatFetcher
  use ExUnit.Case, async: true
  alias HeartbeatCollector.HeartBeats.ApiData

  doctest HeartbeatCollectorWeb.HeartbeatFetcher
  import Ecto.Query
  use Plug.Test
  import Mock

  @opts HeartbeatCollectorWeb.Router.init([])

  # test "get heartbeat status" do
  #   conn  = conn(:get, "/api/heartbeats")

  #   conn = HeartbeatCollectorWeb.Router.call(conn, @opts)

  #   assert conn.status == 404
  # end

  describe "get_status" do
    test "getting the health status of a service" do
      with_mock HeartbeatFetcher, [get_status: fn(params) -> {:ok, %HTTPoison.Response{status_code: 200 } } end] do

         {:ok, response} = HeartbeatFetcher.get_status("http://example.com")
         assert response.status_code == 200
      end

    end
  end
end
