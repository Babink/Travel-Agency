defmodule TravelWeb.Plugs.RequireAdmin do
    import Plug.Conn
    import Phoenix.Controller

    alias TravelWeb.Router.Helpers , as: Routes

    def init(_params) do
    end

    def call(conn , _params) do
        if conn.assigns[:admin] do
            conn
        else
            conn
            |> redirect(to: Routes.admin_path(conn , :login_admin))
            |> halt()
        end
    end
end