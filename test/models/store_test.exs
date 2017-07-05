defmodule PhoenixElastic.StoreTest do
  use PhoenixElastic.ModelCase

  alias PhoenixElastic.Store

  @valid_attrs %{location: "some content", name: "some content", store_code: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Store.changeset(%Store{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Store.changeset(%Store{}, @invalid_attrs)
    refute changeset.valid?
  end
end
