defmodule PhoenixElastic.ProductView do
  use PhoenixElastic.Web, :view

  def render("index.json", %{products: products}) do
    %{data: render_many(products, PhoenixElastic.ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, PhoenixElastic.ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      count: product.count,
      brands: product.brands}
  end
end
