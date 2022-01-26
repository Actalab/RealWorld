# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Realworld.Repo.insert!(%Realworld.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Realworld.Blog.create_user(%{email: "user1@gmail.com", username: "User01", password: "123456", bio: "Bonjour"})
Realworld.Blog.create_user(%{email: "user2@gmail.com", username: "User02", password: "123456", bio: "Bonsoir"})
Realworld.Blog.create_user(%{email: "user3@gmail.com", username: "User03", password: "123456", bio: "Bonne journée"})
Realworld.Blog.create_user(%{email: "user4@gmail.com", username: "User04", password: "123456", bio: "Bonne nuit"})

user1 = Realworld.Repo.get(Realworld.User, 1)
user2 = Realworld.Repo.get(Realworld.User, 2)
user3 = Realworld.Repo.get(Realworld.User, 3)

Realworld.Blog.create_article(user1, %{title: "Article 1", body: "Body 1", description: "Description 1"})
Realworld.Blog.create_article(user1, %{title: "Article 2", body: "Body 2", description: "Description 2"})
Realworld.Blog.create_article(user2, %{title: "Article 3", body: "Body 3", description: "Description 3"})
Realworld.Blog.create_article(user3, %{title: "Article 4", body: "Body 4", description: "Description 4"})

article1 = Realworld.Repo.get(Realworld.Article, 1)
article2 = Realworld.Repo.get(Realworld.Article, 2)
article3 = Realworld.Repo.get(Realworld.Article, 3)

Realworld.Blog.create_comment(user1, article1, %{text: "Commentaire 1"})
Realworld.Blog.create_comment(user1, article2, %{text: "Commentaire 2"})
Realworld.Blog.create_comment(user2, article1, %{text: "Commentaire 3"})
Realworld.Blog.create_comment(user3, article3, %{text: "Commentaire 4"})