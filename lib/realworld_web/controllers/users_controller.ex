defmodule RealworldWeb.UsersController do
  use RealworldWeb, :controller
  
  alias RealworldWeb.Router.Helpers, as: Routes
  
  alias Realworld.Blog

  def show(conn, %{"id" => id}) do
    user = Blog.get_user(id)
    articles = Blog.list_articles_by_user(user)
    render(conn, "show_user.html", articles: articles, user: user)
  end

end