defmodule Realworld.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
		create table (:comments) do
			add :text, :string, null: false
			add :article_id, references(:articles)
			add :author_id, references(:users)

			timestamps()
    end
  end
end
