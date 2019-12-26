defmodule TravelWeb.Book do
    use TravelWeb , :model

    schema "books" do
        field :person , :integer
        field :name , :string
        field :contact , :integer
        field :address , :string
        field :message , :string

        belongs_to :images , TravelWeb.Images
        belongs_to :user , TravelWeb.User

    end

    def changeset(struct , params \\ %{}) do
        struct
        |> cast(params , [:person , :name , :contact , :address , :message])
        |> validate_required([:person , :name , :contact , :address , :message])
    end
end