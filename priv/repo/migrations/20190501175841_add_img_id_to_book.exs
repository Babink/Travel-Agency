defmodule Travel.Repo.Migrations.AddImgIdToBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :image_id , references(:images)
    end
  end
end
