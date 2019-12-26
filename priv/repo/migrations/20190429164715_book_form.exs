defmodule Travel.Repo.Migrations.BookForm do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :person , :integer
      add :start_date , :naive_datetime
      add :name , :string
      add :contact , :integer
      add :address , :string
      add :message , :string
    end
  end
end
