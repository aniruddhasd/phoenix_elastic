defmodule PhoenixElastic.ProductLineControllerTest do
  use PhoenixElastic.ConnCase

  alias PhoenixElastic.ProductLine
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_line_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product_line = Repo.insert! %ProductLine{}
    conn = get conn, product_line_path(conn, :show, product_line)
    assert json_response(conn, 200)["data"] == %{"id" => product_line.id,
      "name" => product_line.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, product_line_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_line_path(conn, :create), product_line: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ProductLine, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_line_path(conn, :create), product_line: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product_line = Repo.insert! %ProductLine{}
    conn = put conn, product_line_path(conn, :update, product_line), product_line: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ProductLine, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product_line = Repo.insert! %ProductLine{}
    conn = put conn, product_line_path(conn, :update, product_line), product_line: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product_line = Repo.insert! %ProductLine{}
    conn = delete conn, product_line_path(conn, :delete, product_line)
    assert response(conn, 204)
    refute Repo.get(ProductLine, product_line.id)
  end
end
