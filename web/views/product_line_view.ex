defmodule PhoenixElastic.ProductLineView do
  use PhoenixElastic.Web, :view

  def render("index.json", %{product_lines: product_lines}) do
    %{data: render_many(product_lines, PhoenixElastic.ProductLineView, "product_line.json")}
  end

  def render("show.json", %{product_line: product_line}) do
    %{data: render_one(product_line, PhoenixElastic.ProductLineView, "product_line.json")}
  end

  def render("product_line.json", %{product_line: product_line}) do
    %{id: product_line.id,
      name: product_line.name,
      products: render_many(product_line.products, PhoenixElastic.ProductView, "product.json")}
  end
end
