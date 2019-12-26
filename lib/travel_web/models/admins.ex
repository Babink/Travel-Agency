defmodule TravelWeb.Admins do
    use TravelWeb , :model


    schema "admin" do
        field :username , :string
        field :password , :string
    end

    def changeset(struct , params \\ %{}) do
        struct
        |> cast(params , [:username , :password])
        |> validate_required([:username , :password])
    end
end