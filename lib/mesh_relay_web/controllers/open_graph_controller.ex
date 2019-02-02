defmodule MeshRelayWeb.OpenGraphController do
  use MeshRelayWeb, :controller

  import OpenGraphExtended
  import HTTPoison

  def index(conn, params) do
    encoded_url = params["url"]
    response = HTTPoison.get!(encoded_url)
    body = response.body

    try do
      og = OpenGraphExtended.parse(body)

      conn |> render("index.json", open_graph: og)
    rescue
      _ -> conn |> send_resp(204, "")
    end
  end
end
