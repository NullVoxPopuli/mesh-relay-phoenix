defmodule MeshRelay.PageController do
  use MeshRelay.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
