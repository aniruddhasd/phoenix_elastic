defmodule PhoenixElastic.Repo.Migrations.CreateStore do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :location, :string
      add :store_code, :integer

      timestamps()
    end

  end
end
