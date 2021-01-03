defmodule ChatWeb.Resolvers.System do
  alias ChatWeb.Schema.ChangesetErrors

  def list_chat_messages(_parent, _args, _resolution) do
    {:ok, Chat.System.list_chat_messages()}
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
end
