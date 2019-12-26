defmodule TravelWeb.User do
    use TravelWeb , :model

    schema "users" do
        field :name , :string
        field :email , :string
        field :password , :string
        has_many :books , TravelWeb.Book
    end

    def changeset(struct , params \\ %{}) do
        struct
        |> cast(params , [:name , :email , :password])
        |> validate_required([:name , :email , :password])
        |> validate_format(:email , ~r/@/)
        |> check_password(:password)
        |> unique_constraint(:email) 
    end

    def check_password(changeset , field, option \\ []) do
        validate_change(changeset , field , fn _ , password -> 
            if String.length(password) >= 6 do
                []
            else
                [{ field , option[:message] || "Password should be longer than 6" }]
            end
        end)
    end
    
end