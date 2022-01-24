defmodule Realworld.User do
	use Ecto.Schema
	import Ecto.Changeset
  
  schema "users" do
    field :email, EctoFields.Email
    field :username, :string
		field :password, :string, virtual: true
		field :password_hash, :string
		field :bio, :string
		many_to_many :favourites_articles, Realworld.Article, join_through: "favourites_articles"
		many_to_many :users_followed, Realworld.User, join_through: "following_table"
		many_to_many :followers_users, Realworld.User, join_through: "following_table"
  end

	def changeset(struct, params) do
		struct
		|> cast(params, [:email, :username, :password_hash, :bio, :password])
		|> validate_required([:email, :username, :password_hash])
	end
end