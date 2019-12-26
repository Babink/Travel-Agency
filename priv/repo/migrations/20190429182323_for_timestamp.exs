defmodule Travel.Repo.Migrations.ForTimestamp do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :person , :bigint
    end
  end
end
