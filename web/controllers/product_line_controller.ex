defmodule PhoenixElastic.ProductLineController do
  use PhoenixElastic.Web, :controller
  alias PhoenixElastic.{ProductLine,Store,StoreView,ESHelper}

  def index(conn, _params) do
    product_lines = Repo.all(ProductLine)
    render(conn, "index.json", product_lines: product_lines)
  end

  def create(conn, %{"store_id" => id, "product_line" => product_line_params}) do
    store = Repo.get(Store,id)
    new_product_line_changeset = ProductLine.changeset(%ProductLine{},product_line_params)
    changeset = ProductLine.changeset(%ProductLine{}, product_line_params)
    product_lines = store.product_lines ++ [new_product_line_changeset]
    changeset =Ecto.Changeset.change(store) |> Ecto.Changeset.put_embed(:product_lines,product_lines)
    case Repo.update(changeset) do
      {:ok, store} ->
        ESHelper.add_document(store) ## ToDo: Ideally add inside a worker & Use update fn of ES
        render(conn,StoreView, "show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElastic.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product_line = Repo.get!(ProductLine, id)
    render(conn, "show.json", product_line: product_line)
  end

  def update(conn, %{"id" => id, "product_line" => product_line_params}) do
    store = Repo.get(Store, id)
    new_product_line_changeset = ProductLine.changeset(%ProductLine{},product_line_params)
    product_lines = Enum.map(store.product_lines, fn product_line -> 
        if product_line.id == product_line_params["id"] do
          new_product_line_changeset
        else
          product_line
        end        
    end)
    changeset = Ecto.Changeset.change(store) |> Ecto.Changeset.put_embed(:product_lines,product_lines)

    case Repo.update(changeset) do
      {:ok, store} ->
        ESHelper.add_document(store) ## ToDo: Ideally add inside a worker & Use update fn of ES
        render(conn,StoreView, "show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElastic.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_line = Repo.get!(ProductLine, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product_line)

    send_resp(conn, :no_content, "")
  end
end
