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

user =
  insert(:user,
    email: "abdulachik@gmail.com"
  )

conversation = insert(:conversation)
messages = insert_list(5, :message, conversation: conversation)

insert(:conversation_member, conversation: conversation, user: user, owner: true)

Enum.each(
  messages,
  &insert(:conversation_member, user: &1.user, conversation: conversation, owner: false)
)
