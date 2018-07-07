defmodule MeshRelayWeb.Router do
  use MeshRelayWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MeshRelayWeb do
    pipe_through(:api)

    get "/open_graph", OpenGraphController, :index
  end
end
