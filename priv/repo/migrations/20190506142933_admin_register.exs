defmodule Travel.Repo.Migrations.AdminRegister do
  use Ecto.Migration

  def change do
    create table(:admin) do
      add :username , :string
      add :password , :string
    end
  end
end
