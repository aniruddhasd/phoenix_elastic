defmodule PhoenixElastic.Repo.Migrations.AddProductLinesToStore do
  use Ecto.Migration

  def change do
	alter table(:stores) do
  		add :product_lines, {:array, :map}, default: []
  	end
  end
end
