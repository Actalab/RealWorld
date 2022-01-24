defmodule Realworld.Article do
  use Ecto.Schema
	alias __MODULE__
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    field :body, :string
    field :description, :string
    field :tag, {:array, :string}
    belongs_to :author, Realworld.User
		has_many :comments, Realworld.Comment, foreign_key: :article_id
    # many_to_many :favourites_users, Realworld.User, join_through: "favourites_articles"

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :body, :description, :tag, :author_id])
		|> cast_assoc(:author)
    |> validate_required([:title, :body, :description])
  end

	def changeset(params), do: changeset(%Article{}, params)
end
