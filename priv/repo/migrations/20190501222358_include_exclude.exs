defmodule Travel.Repo.Migrations.IncludeExclude do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :include , :string
      add :exculde , :string
    end
  end
end
