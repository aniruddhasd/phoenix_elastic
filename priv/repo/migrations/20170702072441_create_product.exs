defmodule PhoenixElastic.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :count, :integer

      timestamps()
    end

  end
end
