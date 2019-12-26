defmodule Travel.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name , :string
      add :email , :string
      add :password , :string
    end
  end
end
