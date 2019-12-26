defmodule Travel.Repo.Migrations.Images do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url , :string
      add :heading , :string
      add :description, :string
      add :price , :string
      add :days , :string
      add :tags , :string
      add :urltwo ,:string
      add :urlthree , :string
      add :urlfour , :string
    end
  end
end
