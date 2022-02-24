defmodule Realworld.User do
  use Ecto.Schema
	alias Realworld.{Article, User}
  import Ecto.Changeset

  schema "users" do
    field :email, EctoFields.Email
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :bio, :string
		has_many :articles, Article, foreign_key: :author_id
    many_to_many :favourites_articles, Realworld.Article, join_through: "favourites_articles", join_keys: [user_id: :id, article_id: :id]
    many_to_many :followed_users, Realworld.User, join_through: "following_table", join_keys: [follower_user_id: :id, followed_user_id: :id]
    many_to_many :followers_users, Realworld.User, join_through: "following_table", join_keys: [followed_user_id: :id, follower_user_id: :id]
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:email, :username, :bio, :password])
    |> validate_required([:email, :username, :password_hash])
    |> handle_password()
  end

  def changeset(params), do: changeset(%User{}, params)

  def registration_changeset(struct, params) do
    struct
    |> cast(params, [:email, :username, :bio, :password])
    |> validate_required([:email, :username, :password])
    |> handle_password()
  end

  defp handle_password(%Ecto.Changeset{valid?: true, changes: %{password: _pass}} = changeset) do
    changeset
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp handle_password(%Ecto.Changeset{} = changeset), do: changeset

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    changeset
    |> put_change(:password_hash, Bcrypt.hash_pwd_salt(pass))
  end

  defp put_password_hash(changeset), do: changeset
end
