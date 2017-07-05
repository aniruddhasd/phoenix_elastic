defmodule PhoenixElastic.Product do
  use PhoenixElastic.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, only: [:id, :name, :count, :brands]}
  embedded_schema do
    field :name, :string
    field :count, :integer
    field :brands, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :count, :brands])
    |> validate_required([:name, :count])
  end
end
