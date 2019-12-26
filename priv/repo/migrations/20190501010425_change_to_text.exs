defmodule Travel.Repo.Migrations.ChangeToText do
  use Ecto.Migration

  def change do
    alter table(:images) do
      modify :description , :text
    end
  end
end
