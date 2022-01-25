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

Realworld.Repo.insert!(%Realworld.User{email: "user1@gmail.com", username: "User01", password_hash: "12345", bio: "Bonjour"})
Realworld.Repo.insert!(%Realworld.User{email: "user2@gmail.com", username: "User02", password_hash: "23456", bio: "Bonsoir"}})
Realworld.Repo.insert!(%Realworld.User{email: "user3@gmail.com", username: "User03", password_hash: "34567", bio: "Bonne journée"}})
Realworld.Repo.insert!(%Realworld.User{email: "user4@gmail.com", username: "User04", password_hash: "45678", bio: "Bonne nuit"}})
Realworld.Repo.insert!(%Realworld.Article{title: "Article 1", body: "Body 1", description: "Description 1"})
Realworld.Repo.insert!(%Realworld.Article{title: "Article 2", body: "Body 2", description: "Description 2"})
Realworld.Repo.insert!(%Realworld.Article{title: "Article 3", body: "Body 3", description: "Description 3"})
Realworld.Repo.insert!(%Realworld.Article{title: "Article 4", body: "Body 4", description: "Description 4"})
Realworld.Repo.insert!(%Realworld.Comment{text: "Commentaire 1"})
Realworld.Repo.insert!(%Realworld.Comment{text: "Commentaire 2"})
Realworld.Repo.insert!(%Realworld.Comment{text: "Commentaire 3"})
Realworld.Repo.insert!(%Realworld.Comment{text: "Commentaire 4"})
