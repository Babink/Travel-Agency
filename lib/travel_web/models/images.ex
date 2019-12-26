defmodule TravelWeb.Images do
    use TravelWeb , :model

    schema "images" do
        field :url , :string
        field :heading , :string
        field :description , :string
        field :price , :string
        field :days , :string
        field :tags , :string
        field :urltwo , :string
        field :urlthree , :string
        field :urlfour , :string
        field :include , :string
        field :exculde , :string

        has_many :books , TravelWeb.Book
    end

    def changeset(struct , params \\ %{}) do
        struct
        |> cast(params , [:url , :heading , :description , :price , :days , :tags , :urltwo , :urlthree , :urlfour])
    end
end