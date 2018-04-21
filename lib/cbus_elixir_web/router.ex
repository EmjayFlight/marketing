defmodule CbusElixirWeb.Router do
  use CbusElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
    plug Phauxth.Remember
  end

  scope "/", CbusElixirWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController do
      get "/admin", UserController, :admin, as: :admin
      resources "/speakers", SpeakerController do
        post "/approve_speaker/:id", SpeakerController, :approve_speaker, as: :approve_speaker
      end
    end
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

end
