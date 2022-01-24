defmodule Realworld.Comment do
  use Ecto.Schema
	alias __MODULE__
  import Ecto.Changeset

  schema "comments" do
    field :text, :string
    belongs_to :author, Realworld.User
    belongs_to :article, Realworld.Article

		timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:text, :author_id, :article_id])
    |> validate_required([:text])
  end

	def changeset(params), do: changeset(%Comment{}, params)
end
