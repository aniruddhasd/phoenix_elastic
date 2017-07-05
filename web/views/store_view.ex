defmodule PhoenixElastic.StoreView do
  use PhoenixElastic.Web, :view

  def render("index.json", %{stores: stores}) do
    %{data: render_many(stores, PhoenixElastic.StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{data: render_one(store, PhoenixElastic.StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{id: store.id,
      name: store.name,
      location: store.location,
      store_code: store.store_code,
      product_lines: render_many(store.product_lines, PhoenixElastic.ProductLineView, "product_line.json")}
  end
end
