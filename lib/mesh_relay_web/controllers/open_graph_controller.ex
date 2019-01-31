defmodule MeshRelayWeb.OpenGraphController do
  use MeshRelayWeb, :controller

  import OpenGraphExtended
  import HTTPoison

  def index(conn, params) do
    encoded_url = params["url"]
    response = HTTPoison.get!(encoded_url)
    body = response.body

    og =
      try do
        OpenGraphExtended.parse(body)
      rescue
        _ -> %{}
      end


    conn
    |> render("index.json", open_graph: og)
  end
end
