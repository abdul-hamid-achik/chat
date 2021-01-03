# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chat.Repo.insert!(%Chat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Chat.Factory

Chat.Users.create(%{
  email: "abdulachik@gmail.com",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
})
