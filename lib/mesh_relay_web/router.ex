defmodule MeshRelayWeb.Router do
  use MeshRelayWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"

    plug(:accepts, ["json"])
  end

  scope "/", MeshRelayWeb do
    pipe_through(:api)

    get "/open_graph", OpenGraphController, :index
    options "/open_graph", OpenGraphController, :options
  end
end
