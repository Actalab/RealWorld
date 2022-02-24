defmodule RealworldWeb.UsersController do
  use RealworldWeb, :controller
  
  alias RealworldWeb.Router.Helpers, as: Routes
  
  alias Realworld.{Blog, User}

  def show(conn, %{"id" => id}) do
    user = Blog.get_user(id)
    articles = Blog.list_articles_by_user(user)
		conn
		|> set_user_into_session()
    |> render("show_user.html", articles: articles, user: user)
  end

	def new(conn, _params) do
		changeset = User.changeset(%{})
    render conn, "new_user.html", changeset: changeset
	end

	def create(conn, %{"user" => user_params} = _params) do
    {:ok, user} = Blog.create_user(user_params)
    redirect conn, to: Routes.users_path(conn, :show, user)
  end

	def edit(conn, %{"id" => id}) do
    #user = Blog.get_user(id)
		user = Blog.get_user(1)
    changeset = User.changeset(user, %{})
    render(conn, "edit_user.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params} = _params) do
    #user = Blog.get_user(id)
		user = Blog.get_user(1)
    {:ok, user} = Blog.update_user(user, user_params)
    redirect conn, to: Routes.users_path(conn, :show, user)
  end

	def fav(conn, %{"id" => id}) do
		user = Blog.get_user(id)
		fav_articles = Blog.list_fav_article_by_user(user)
    render(conn, "show_fav.html", fav_articles: fav_articles, user: user)
	end

	def follow(conn, %{"id" => user_id_to_follow}) do
		current_user = Blog.get_user(1)
		user_to_follow = Blog.get_user(user_id_to_follow)
		Blog.follow_user(current_user, user_to_follow)
		redirect conn, to: Routes.users_path(conn, :show, user_to_follow)
	end

  def unfollow(conn, %{"id" => user_id_to_unfollow}) do
		current_user = Blog.get_user(1)
		user_to_unfollow = Blog.get_user(user_id_to_unfollow)
		Blog.unfollow_user(current_user, user_to_unfollow)
		redirect conn, to: Routes.users_path(conn, :show, user_to_unfollow)
	end

end