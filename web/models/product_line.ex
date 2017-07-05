defmodule PhoenixElastic.ProductLine do
  use PhoenixElastic.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, only: [:id, :name, :products]}
  embedded_schema do
    field :name, :string
    embeds_many :products, PhoenixElastic.Product, on_replace: :delete
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> cast_embed(:products)
    |> validate_required([:name, :products])
  end
end
