defmodule Travel.Repo.Migrations.AddIdInImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :book_id , references(:books)
    end
  end
end
