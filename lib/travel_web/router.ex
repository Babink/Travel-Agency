defmodule TravelWeb.Router do
  use TravelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TravelWeb.Plugs.SetUser
    plug TravelWeb.Plugs.SetAdmin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TravelWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/book/:id" , HomeController , :book
    post "/book/:id" , HomeController , :book_post
    get "/heritage/:id" , HomeController , :heritage
    post "/heritage/:id" , HomeController , :heritage_post
    get "/park" , HomeController , :park
    get "/trek" , HomeController , :trek
    get "/bhutan/:id" , HomeController , :bhutan
    post "/bhutan/:id" , HomeController , :bhutan_post
    get "/about" , HomeController , :about
  end

  scope "/auth/" , TravelWeb do
    pipe_through :browser

    get "/signup" , AuthController , :create_acc
    post "/signup" , AuthController , :signup

    get "/login" , AuthController , :login_page
    post "/login" , AuthController , :login

    get "/admin" , AdminController , :login_admin
    post "/admin" , AdminController , :post_admin

    get "/logout" , AuthController , :logout
    get "/admin/logout" , AdminController , :delete_admin
  end

  scope "/admin" , TravelWeb do
    pipe_through :browser

    get "/post" , AdminController , :images
    post "/post" , AdminController , :images_post

    get "/view" , AdminController , :get_post
    get "/detail/:id" , AdminController , :get_detail
  end

  # Other scopes may use custom stacks.
  # scope "/api", TravelWeb do
  #   pipe_through :api
  # end
end
