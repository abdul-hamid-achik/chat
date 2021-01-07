defmodule ChatWeb.Resolvers.System do
  alias ChatWeb.Schema.ChangesetErrors

  def list_chat_messages(_parent, %{conversation_id: conversation_id}, _resolution) do
    {:ok, Chat.System.list_conversation_messages(conversation_id)}
  end

  def list_conversations(_parent, _args, _resolution) do
    {:ok, Chat.System.list_conversations()}
  end

  def create_message(_, args, %{context: %{current_user: user}}) do
    attrs = args |> Map.put(:user_id, user.id)

    case Chat.System.create_message(attrs) do
      {:ok, message} ->
        {:ok, message}

      {:error, changeset} ->
        {:error,
         message: "Could not create Message", details: ChangesetErrors.error_details(changeset)}
    end
  end

  def create_conversation(_, args, %{context: %{current_user: user}}) do
    attrs = args |> Map.put(:user_id, user.id)

    with {:ok, conversation} <-
           Chat.System.create_conversation(attrs),
         {:ok, _member} <-
           Chat.System.create_conversation_member(%{
             user_id: user.id,
             conversation_id: conversation.id,
             owner: true
           }) do
      {:ok, conversation}
    else
      {:error, changeset} ->
        {:error,
         message: "Could not create Conversation",
         details: ChangesetErrors.error_details(changeset)}
    end
  end
end
