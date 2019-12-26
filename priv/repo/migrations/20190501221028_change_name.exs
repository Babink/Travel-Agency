defmodule Travel.Repo.Migrations.ChangeName do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :image_id 
      add :images_id , references(:images)
    end
  end
end
