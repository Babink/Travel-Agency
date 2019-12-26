defmodule Travel.Repo.Migrations.TweakTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :image_id
    end
  end
end
