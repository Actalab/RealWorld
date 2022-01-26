defmodule Realworld.Blog do
  alias Realworld.{Repo, User, Article, Comment}
  import Ecto.{Changeset, Query}

  # -----------USERS-----------#
  # def registration_changeset(struct, params) do
  #   struct
  #   |> cast(params, [:email, :username, :password_hash])
  # end

  def create_user(params) do
    # %User{}
    # |> User.registration_changeset(params)
    # |> put_change(:password_hash, hashed_password(params["password"]))
    # |> Repo.insert!()
    changeset = User.registration_changeset(%User{}, params)
    Repo.insert!(changeset)
  end

  def get_user(params) do
    #Repo.get_by(User, email: String.downcase(params["email"]))
    Repo.get_by(User, id: "1")
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _ -> Bcrypt.check_pass(user, password)
    end
  end

  def update_user(user, change_attributes) do
    user_changeset = User.registration_changeset(user, change_attributes)
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

  def get_article(article_id) do
    Repo.get(Article, article_id)
  end

  def list_articles do
    query = from(Article)
    Repo.all(query)
  end

  def list_articles_by_user(user) do
    user = Repo.get(User, user.id)
    articles = Repo.all Ecto.assoc(user, :articles)
    [user] = Repo.all(from(u in User, where: u.id == ^user.id, preload: :articles))
    Realworld.Repo.preload(user.articles, [:author, :comments])
  end

  def delete_article(article) do
    Repo.delete(article)
  end

  def add_fav_article(user, article) do
    user = Repo.preload(user, [:articles, :favourites_articles])
    user_changeset = Ecto.Changeset.change(user)
    user_favourites_changeset = user_changeset |> Ecto.Changeset.put_assoc(:favourites_articles, [article])
    Repo.update!(user_favourites_changeset)
  end

  def get_fav_article_by_user(user) do
    #query = from()
  end

  # -----------COMMENTS-----------#
  def create_comment(attributes) do
    %Comment{}
    |> Comment.changeset(attributes)
    |> Repo.insert()
  end

  def delete_comment(comment) do
    Repo.delete(comment)
  end

  def get_comment(comment_id) do
    #query = from(Comment, where: [id: ^comment_id], select: [:text])
    Repo.get(Comment, comment_id)
  end

  def list_all_comments() do
    query = from(Comment)
    Repo.all(query)
  end

  def list_comments_by_article(article) do
    #query = from(Comment, where: [article_id: ^article.id], select: [:text])
    #Repo.all(query)
    article = Repo.get(Article, article.id)
    comments = Repo.all Ecto.assoc(article, :comments)
    [article] = Repo.all(from(a in Article, where: a.id == ^article.id, preload: :comments))
    article.comments
  end

  def list_comments_by_user(user) do
    query = from(Comment, where: [author_id: ^user.id], select: [:text])
    Repo.all(query)
  end
end
