defmodule HeartbeatCollector.Repo.Migrations.CreateApidata do
  use Ecto.Migration

  def change do
    create table(:apidata) do
      add :servicename, :string
      add :url, :string
      add :status, :string
      add :lastchecked, :string

      timestamps()
    end

    create unique_index(:apidata, [:servicename])
  end
end
