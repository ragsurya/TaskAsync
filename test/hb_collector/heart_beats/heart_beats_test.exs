defmodule HeartbeatCollector.HeartBeatsTest do
  use HeartbeatCollector.DataCase

  alias HeartbeatCollector.HeartBeats

  describe "apidata" do
    alias HeartbeatCollector.HeartBeats.ApiData

    @valid_attrs %{servicename: "some servicename", url: "http://someurl.com/ping", status: "200", lastchecked: "nothing"}
    @update_attrs %{servicename: "some updated servicename", url: "http://someurl1.com/ping", status: "404", lastchecked: "nothing1"}
    @invalid_attrs %{servicename: nil, url: nil, status: nil, lastchecked: nil}

    def api_data_fixture(attrs \\ %{}) do
      {:ok, api_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HeartBeats.create_api_data()

      api_data
    end

    test "list_apidata/0 returns all apidata" do
      api_data = api_data_fixture()
      assert HeartBeats.list_apidata() == [api_data]
    end

    test "get_api_data!/1 returns the api_data with given id" do
      api_data = api_data_fixture()
      assert HeartBeats.get_api_data!(api_data.id) == api_data
    end

    test "create_api_data/1 with valid data creates a api_data" do
      assert {:ok, %ApiData{} = api_data} = HeartBeats.create_api_data(@valid_attrs)
      assert api_data.servicename == "some servicename"
    end

    test "create_api_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HeartBeats.create_api_data(@invalid_attrs)
    end

    test "update_api_data/2 with valid data updates the api_data" do
      api_data = api_data_fixture()
      assert {:ok, %ApiData{} = api_data} = HeartBeats.update_api_data(api_data, @update_attrs)
      assert api_data.servicename == "some updated servicename"
    end

    test "update_api_data/2 with invalid data returns error changeset" do
      api_data = api_data_fixture()
      assert {:error, %Ecto.Changeset{}} = HeartBeats.update_api_data(api_data, @invalid_attrs)
      assert api_data == HeartBeats.get_api_data!(api_data.id)
    end

    test "delete_api_data/1 deletes the api_data" do
      api_data = api_data_fixture()
      assert {:ok, %ApiData{}} = HeartBeats.delete_api_data(api_data)
      assert_raise Ecto.NoResultsError, fn -> HeartBeats.get_api_data!(api_data.id) end
    end

    test "change_api_data/1 returns a api_data changeset" do
      api_data = api_data_fixture()
      assert %Ecto.Changeset{} = HeartBeats.change_api_data(api_data)
    end
  end
end
