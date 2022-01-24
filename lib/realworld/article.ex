defmodule Realworld.Article do
	use Ecto.Schema
	import Ecto.Changeset
  
  schema "articles" do
    field :title, :string
    field :body, :string
    field :description, :string
    field :tag, {:array, :string}
		belongs_to :author, Realworld.User
		many_to_many :users_favourites, Realworld.User, join_through: "favourites_articles"

		timestamps()
  end

	def changeset(struct, params) do
		struct
		|> cast(params, [:title, :body, :description, :tag])
		|> validate_required([:title, :body, :description])
	end
end