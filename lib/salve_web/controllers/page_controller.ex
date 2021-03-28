defmodule SalveWeb.PageController do
  use SalveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
