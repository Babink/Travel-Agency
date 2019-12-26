defmodule Travel.Repo.Migrations.DeleteTime do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :start_date
    end
  end
end
