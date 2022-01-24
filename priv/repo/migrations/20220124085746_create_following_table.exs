defmodule Realworld.Repo.Migrations.CreateFollowingTable do
  use Ecto.Migration

  def change do
    create table (:following_table) do
      add :followed_user_id, references(:users)
      add :follower_user_id, references(:users)
    end

    create unique_index(:following_table, [:followed_user_id, :followed_user_id])
  end
end
