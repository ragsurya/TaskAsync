defmodule HeartbeatCollector.HeartBeats.ApiData do
  use Ecto.Schema
  import Ecto.Changeset


  schema "apidata" do
    field :servicename, :string
    field :url, :string
    field :status, :string
    field :lastchecked, :string

    timestamps()
  end

  @doc false
  def changeset(api_data, attrs) do
    api_data
    |> cast(attrs, [:servicename, :url, :status, :lastchecked])
    |> validate_required([:servicename, :url, :status, :lastchecked])
    |> unique_constraint(:servicename)
  end
end
