defmodule TravelWeb.Plugs.SetAdmin do
    import Plug.Conn
    import Phoenix.Controller

    alias Travel.Repo
    alias TravelWeb.Admins

    def init(_params) do
    end

    def call(conn , _params) do
        admin_id = get_session(conn , :admin)

        cond do
            admin = admin_id && Repo.get(Admins , admin_id) ->
                assign(conn , :admin , admin)
            true ->
                assign(conn , :admin , nil)
        end
    end
end