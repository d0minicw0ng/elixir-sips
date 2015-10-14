defmodule MarkdownServer.Router do
  use MarkdownServer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarkdownServer do
    pipe_through :browser # Use the default browser stack

    get "/",           PageController, :index
    get "pages/:page", PageController, :show,  as: :page
    get "pages",       PageController, :index, as: :page
  end

  # Other scopes may use custom stacks.
  # scope "/api", MarkdownServer do
  #   pipe_through :api
  # end
end
