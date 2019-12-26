defmodule TravelWeb.Plugs.RequireAuth do
    import Plug.Conn
    import Phoenix.Controller

    alias TravelWeb.Router.Helpers , as: Route

    def init(_params)do
    end

    def call(conn , _params) do
        if conn.assigns[:user] do
            conn
        else
            conn
            |> redirect(to: Route.auth_path(conn , :login_page))
            |> halt()
        end
    end
end