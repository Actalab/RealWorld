defmodule Realworld.Repo.Migrations.CreateFavouritesArticles do
  use Ecto.Migration

  def change do
    create table(:favourites_articles) do
      add :article_id, references(:articles)
      add :user_id, references(:users)
    end

    create unique_index(:favourites_articles, [:article_id, :user_id])
  end
end
