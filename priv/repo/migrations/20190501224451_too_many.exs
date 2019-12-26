defmodule Travel.Repo.Migrations.TooMany do
  use Ecto.Migration

  def change do
    alter table(:images) do
      modify :include , :text
      modify :exculde , :text
    end
  end
end
