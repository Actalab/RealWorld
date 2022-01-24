defmodule Realworld.Blog do
  alias Realworld.{Repo, User, Article, Comment}
  import Ecto.{Changeset, Query}

  # -----------USERS-----------#
  def registration_changeset(struct, params) do
    struct
    |> cast(params, [:email, :username, :password_hash])
  end

  def create_user(params) do
    %User{}
    |> registration_changeset(params)
    |> put_change(:password_hash, hashed_password(params["password"]))
    |> Repo.insert!()
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def get_user(params) do
    Repo.get_by(User, email: String.downcase(params["email"]))
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def update_user(user, change_attributes) do
    user_changeset = User.changeset(user, change_attributes)
    Repo.update!(user_changeset)
  end

  def follow_user() do

  end

  def list_users() do
    
  end

  # -----------ARTICLES-----------#
  def create_article(attributes) do
    %Article{}
    #|> Ecto.build_assoc(:author)
    #|> Ecto.build_assoc(:favourites_users)
    |> Article.changeset(attributes)
    |> Repo.insert()
  end

  def update_article(article, change_attributes) do
    article
    |> Article.changeset(change_attributes)
    |> Repo.update()
  end

  def get_article do
    query = from(Article)
    Repo.all(query)
  end

  def delete_article(article) do
    Repo.delete(article)
  end

  def fav_article() do
  end

  # -----------COMMENTS-----------#
  def create_comment(attributes) do
    %Comment{}
    |> Comment.changeset(attributes)
    |> Repo.insert()
  end

  def delete_comment() do
  end

  def get_comment() do
    
  end
end
