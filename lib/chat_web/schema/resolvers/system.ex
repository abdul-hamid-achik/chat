defmodule ChatWeb.Schema.Resolvers.System do
  alias ChatWeb.Schema.ChangesetErrors

  def list_chat_messages(_parent, %{conversation_id: conversation_id}, _resolution) do
    {:ok, Chat.System.list_conversation_messages(conversation_id)}
  end

  def list_conversations(_parent, _args, _resolution) do
    {:ok, Chat.System.list_conversations()}
  end

  def create_message(_, args, %{context: %{current_user: user}}) do
    params = build_params(args, user)

    case Chat.System.create_message(params) do
      {:ok, message} ->
        {:ok, message}

      {:error, changeset} ->
        {:error,
         message: "Could not create Message", details: ChangesetErrors.error_details(changeset)}
    end
  end

  def create_conversation(_, args, %{context: %{current_user: user}}) do
    params = build_params(args, user)

    with {:ok, conversation} <-
           Chat.System.create_conversation(params),
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

  def create_attachment(
        _,
        args,
        %{context: %{current_user: user}}
      ) do
    params = build_params(args, user)
    Chat.System.create_attachment(params)
  end

  defp build_params(args, user) do
    Map.put(args, :user_id, user.id)
  end
end
