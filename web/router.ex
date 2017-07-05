defmodule PhoenixElastic.Router do
  use PhoenixElastic.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixElastic do
    pipe_through :api
    resources "/stores", StoreController, except: [:new, :edit]
    resources "/product_lines", ProductLineController, except: [:new, :edit]
    resources "/products", ProductController, except: [:new, :edit]
  end
end
