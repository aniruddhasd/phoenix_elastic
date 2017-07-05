defmodule PhoenixElastic.Store do
  use PhoenixElastic.Web, :model
  @derive {Poison.Encoder, only: [:id, :name, :location, :store_code, :product_lines]}
  schema "stores" do
    field :name, :string
    field :location, :string
    field :store_code, :integer
    embeds_many :product_lines, PhoenixElastic.ProductLine, on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location, :store_code])
    |> cast_embed(:product_lines)
    |> validate_required([:name, :location, :store_code])
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location, :store_code])
    |> validate_required([:name, :location, :store_code])  
  end  
end
