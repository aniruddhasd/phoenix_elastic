defmodule PhoenixElastic.StoreController do
  use PhoenixElastic.Web, :controller

  alias PhoenixElastic.{Store,ESHelper}

  def index(conn, _params) do
    stores = Repo.all(Store)
    render(conn, "index.json", stores: stores)
  end

  def create(conn, %{"store" => store_params}) do
    changeset = Store.changeset(%Store{}, store_params)

    case Repo.insert(changeset) do
      {:ok, store} ->
        ESHelper.add_document(store) ## ToDo: Ideally add inside a worker
        conn
        |> put_status(:created)
        |> put_resp_header("location", store_path(conn, :show, store))
        |> render("show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElastic.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    store = Repo.get!(Store, id)
    render(conn, "show.json", store: store)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Repo.get!(Store, id)
    changeset = Store.update_changeset(store, store_params)

    case Repo.update(changeset) do
      {:ok, store} ->
        ESHelper.add_document(store) ## ToDo: Ideally add inside a worker & Use update fn of ES
        render(conn, "show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElastic.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Repo.get!(Store, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(store)

    send_resp(conn, :no_content, "")
  end
end
