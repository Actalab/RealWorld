defmodule Realworld.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :text, :string
    belongs_to :author, Realworld.User
    belongs_to :article, Realworld.Article

		timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:text])
    |> validate_required([:text])
  end
end
