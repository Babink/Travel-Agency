defmodule Travel.Repo.Migrations.AddValue do
  use Ecto.Migration

  def change do
    alter table(:images) do
      remove :book_id
    end
  end
end
