defmodule MeshRelay.Web.Router do
  use MeshRelay.Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MeshRelay.Web do
    pipe_through(:api)

    get("open_graph", OpenGraphController, :index)
  end
end
