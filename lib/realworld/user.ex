defmodule Realworld.User do
  use Ecto.Schema
	alias Realworld.Article
  import Ecto.Changeset

  schema "users" do
    field :email, EctoFields.Email
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :bio, :string
		has_many :articles, Article, foreign_key: :author_id
    many_to_many :favourites_articles, Realworld.Article, join_through: "favourites_articles", join_keys: [user_id: :id, article_id: :id]
    # many_to_many :followed_users, Realworld.User, join_through: "following_table"
    # many_to_many :followers_users, Realworld.User, join_through: "following_table"
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:email, :username, :password_hash, :bio, :password])
    |> validate_required([:email, :username, :password])
    #|> unique_constraint(:email)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))    
      _ ->
        changeset  
    end
  end
end
