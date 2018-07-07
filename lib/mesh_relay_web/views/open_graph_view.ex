defmodule MeshRelayWeb.OpenGraphView do
  use MeshRelayWeb, :view

  def render("index.json", %{open_graph: open_graph}) do
    %{
      data: open_graph
    }
  end
end
