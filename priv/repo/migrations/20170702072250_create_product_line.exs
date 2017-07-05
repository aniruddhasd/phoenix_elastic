defmodule PhoenixElastic.Repo.Migrations.CreateProductLine do
  use Ecto.Migration

  def change do
    create table(:product_lines) do
      add :name, :string

      timestamps()
    end

  end
end
