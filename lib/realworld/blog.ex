defmodule Realworld.Blog do
  alias Realworld.{Repo, User, Article, Comment}
  import Ecto.{Changeset, Query}
  @default_article_pagination_limit 10

  # -----------USERS-----------#
  # def registration_changeset(struct, params) do
  #   struct
  #   |> cast(params, [:email, :username, :password_hash])
  # end

  def create_user(params) do
    %User{}
    |> User.registration_changeset(params)
    |> Repo.insert!()
  end

  def get_user(user_id, preload_associations \\ []) do
    User
    |> Repo.get_by(id: user_id)
    |> Repo.preload(preload_associations)
  end

  def authenticate(user, password) do
    case user do
      nil -> {:error, "invalid user"}
      _ -> Bcrypt.check_pass(user, password)
    end
  end

  def update_user(user, change_attributes) do
    user
    |> User.changeset(change_attributes)
    |> Repo.update()
  end

  def update_user!(user, change_attributes) do
    {:ok, updated_user} = update_user(user, change_attributes)
    updated_user
  end


  def follow_user(user, user_to_follow) do
    #preloaded_user = Repo.preload(user, [:articles, :favourites_articles, :followed_users, :followers_users])
    #preloaded_user
    preloaded_user = Repo.preload(user, [:articles, :favourites_articles, :followed_users, :followers_users])
    preloaded_user
    |> change() 
    |> put_assoc(:followed_users, preloaded_user.followed_users ++ [user_to_follow])
    |> Repo.update!()
  end

  def unfollow_user(user, user_to_unfollow) do
    query = from(f in "following_table", where: f.followed_user_id == ^user_to_unfollow.id and f.follower_user_id == ^user.id, select: [:followed_user_id, :follower_user_id])
    Repo.delete_all(query)
  end

  #FROM @Thibaud
  def list_followed(%{followed_users:  %Ecto.Association.NotLoaded{}} = user) do
    IO.inspect(user.id, label: "list_followed/1 user no followed assoc")
    user
    |> Repo.preload([:followed_users])
    |> list_followed()
  end

  def list_followed(%{followed_users: followed_users} = user) do
    IO.inspect(user.id, label: "list_followed/1 user has followed assoc")
    followed_users
  end

  def list_followers(user) do
    %{followers_users: followers_users} = Repo.preload(user, :followers_users)
    followers_users
  end

  def list_users(preload_associations \\ []) do
    User
    |> from()
    |> Repo.all()
    |> Repo.preload(preload_associations)
    #query = from(User)
    #Repo.all(query)
  end

  # -----------ARTICLES-----------#
  def create_article(user, attributes) do
    %Article{author_id: user.id}
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

  def get_article(article_id, preload_associations \\ []) do
    Article
    |> Repo.get(article_id)
    |> Repo.preload(preload_associations)
  end

  def list_articles(params) do
    limit = params["limit"] || @default_article_pagination_limit
    offset = params["offset"] || 0
    
    from(a in Article, limit: ^limit, offset: ^offset, order_by: a.inserted_at)
    |> filter_by_tags(params["tag"])
    |> Repo.all()
    # Article
    # |> from()
    # |> Repo.all()
    #query = from(Article)
    #Repo.all(query)
  end

  def filter_by_tags(query, nil) do
    query
  end

  def filter_by_tags(query, tag) do
    from q in query, where: ^tag in q.tag
  end

  def list_articles_by_user(user) do
    _articles = Repo.all Ecto.assoc(user, :articles)
    [user] = Repo.all(from(u in User, where: u.id == ^user.id, preload: :articles))
    Realworld.Repo.preload(user.articles, [:author, :comments])
  end

  def delete_article(article) do
    Repo.delete(article)
  end

  def add_fav_article(user, article) do
    # user = Repo.preload(user, [:articles, :favourites_articles])
    # user_changeset = change(user)
    # user_favourites_changeset = user_changeset |> put_assoc(:favourites_articles, [article])
    # Repo.update!(user_favourites_changeset)
    Repo.preload(user, [:articles, :favourites_articles])
    |> change()
    |> put_assoc(:favourites_articles, [article])
    |> Repo.update!()
  end

  def unfav_article(user, article) do
    query = from(f in "favourites_articles", where: f.article_id == ^article.id and f.user_id == ^user.id, select: [:article_id, :user_id])
    Repo.delete_all(query)
  end

  def list_fav_article_by_user(user) do
    # query = from(u in User, join: f in assoc(u, :favourites_articles), preload: [favourites_articles: f])
    # user = Repo.all(query)
    user = Repo.preload(user, :favourites_articles)
    user.favourites_articles
  end

  def list_articles_of_followed(user) do
    #list_followers(user)
    Repo.all(from(a in Article, join: ft in "following_table", on: a.author_id == ft.followed_user_id, where: ft.follower_user_id == ^user.id))
  end

  def list_tags() do
    from(a in Article, where: not is_nil(a.tag), select: a.tag)
    |> Repo.all()
    |> List.flatten()
    |> Enum.uniq()
  end

  # -----------COMMENTS-----------#
  def create_comment(user, article, attributes) do
    %Comment{article_id: article.id, author_id: user.id}
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
    Comment
    |> from()
    |> Repo.all()
    # query = from(Comment)
    # Repo.all(query)
  end

  def list_comments_by_article(article) do
    #query = from(Comment, where: [article_id: ^article.id], select: [:text])
    #Repo.all(query)
    #article = Repo.get(Article, article.id)
    _comments = Repo.all Ecto.assoc(article, :comments)
    [article] = Repo.all(from(a in Article, where: a.id == ^article.id, preload: :comments))
    article.comments
  end

  def list_comments_by_user(user) do
    Comment
    |> from(where: [author_id: ^user.id], select: [:text])
    |> Repo.all()
    # query = from(Comment, where: [author_id: ^user.id], select: [:text])
    # Repo.all(query)
  end
end
