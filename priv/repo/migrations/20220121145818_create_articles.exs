defmodule Realworld.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string, null: false
      add :body, :text, null: false
      add :description, :string, null: false
      add :tag, {:array, :string}
      add :author_id, references(:users)

      timestamps()
    end
  end
end
