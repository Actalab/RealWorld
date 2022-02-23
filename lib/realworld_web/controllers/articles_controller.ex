defmodule RealworldWeb.ArticlesController do
  use RealworldWeb, :controller

  alias RealworldWeb.Router.Helpers, as: Routes
  
  alias Realworld.{Article, Blog}

  def index(conn, _params) do
    articles = Blog.list_articles(%{"limit" => 10, "offset" => 0})
    IO.inspect(articles)
    tags = Blog.list_tags()
    render(conn, "index.html", articles: articles, tags: tags)
  end
  
  def show(conn, %{"id" => id}) do
    article = Blog.get_article(id)
    comments = Blog.list_comments_by_article(article)
    render(conn, "show.html", article: article, comments: comments)
  end

  def new(conn, _params) do
    changeset = Article.changeset(%{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"article" => article_params} = _params) do
    user = Blog.get_user(1)
    article_params = Blog.handle_tags(article_params)
    {:ok, article} = Blog.create_article(user, article_params)
    redirect conn, to: Routes.articles_path(conn, :show, article)
  end

  def edit(conn, %{"id" => id}) do
    article = Blog.get_article(id)
    changeset = Article.changeset(article, %{})
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params} = _params) do
    article = Blog.get_article(id)
    article_params = Blog.handle_tags(article_params)
    {:ok, article} = Blog.update_article(article, article_params)
    redirect conn, to: Routes.articles_path(conn, :show, article)
  end

end