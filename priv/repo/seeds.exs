import Chat.Factory

user =
  insert(:user,
    email: "abdulachik@gmail.com"
  )

conversations = insert_list(1, :conversation)

Enum.each(conversations, fn conversation ->
  messages = insert_list(2, :message, conversation: conversation)

  insert(:conversation_member, conversation: conversation, user: user, owner: true)

  Enum.each(
    messages,
    &insert(:conversation_member, user: &1.user, conversation: conversation, owner: false)
  )
end)
