defmodule Travel.Repo.Migrations.AlterBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :contact , :bigint
      modify :start_date , :utc_datetime
    end
  end
end
