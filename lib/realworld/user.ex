defmodule Realworld.User do
	use Ecto.Schema
	import Ecto.Changeset
  
  schema "users" do
    field :email, EctoFields.Email
    field :username, :string
		field :password, :string, virutal: true
		field :password_hash, :string
		field :bio, :string
  end

	def changeset(struct, params) do
		struct
		|> cast(params, [:email, :username, :password_hash, :bio, :password])
		|> validate_required([:email, :username, :password_hash])
	end
end