defmodule RealworldWeb.PageController do
  use RealworldWeb, :controller

  alias RealworldWeb.Router.Helpers, as: Routes

  alias Realworld.Blog

  def index(conn, _params) do
    articles = Blog.list_articles(%{"limit" => 10, "offset" => 0})
    tags = Blog.list_tags()
    render(conn, "index.html", articles: articles, tags: tags)
  end
end
