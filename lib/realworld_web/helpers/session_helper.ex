defmodule RealworldWeb.Helpers.SessionHelper do
    alias Realworld.Blog
    import Plug.Conn
    import Phoenix.Controller
    @default_current_user_id 1
    @default_current_user_key :session_user_id
  
    def set_user_into_session(conn) do
        put_session(conn, @default_current_user_key, @default_current_user_id)
    end

    def get_user_id_session(conn) do
        get_session(conn, @default_current_user_key)
    end

    def get_user_session(conn) do
        conn
        |> get_user_id_session()
        |> Blog.get_user()
    end
  
  end