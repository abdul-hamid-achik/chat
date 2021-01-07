defmodule Chat.System do
  @moduledoc """
  the guts for the application.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.System.{
    Conversation,
    Conversations,
    ConversationMember,
    Message,
    Messages,
    Conversations.Members,
    ConversationMember
  }

  defdelegate list_conversations(), to: Conversations, as: :list
  defdelegate get_conversation!(id), to: Conversations, as: :get!
  defdelegate create_conversation(attrs), to: Conversations, as: :create

  defdelegate list_conversation_messages(conversation_id), to: Messages, as: :list
  defdelegate create_message(attrs), to: Messages, as: :create

  defdelegate create_conversation_member(attrs), to: Members, as: :create

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Conversation, %{limit: limit}) do
    Conversation
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
  end

  def query(ConversationMember, %{limit: limit}) do
    ConversationMember
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
  end

  def query(Message, %{user: nil, limit: limit}) do
    Message
    |> order_by(asc: :inserted_at)
    |> limit(^limit)
  end

  def query(Message, %{limit: limit}) do
    Message
    |> order_by(asc: :inserted_at)
    |> limit(^limit)
  end

  def query(Message, %{user: user, limit: limit}) do
    Message
    |> where(user: ^user)
    |> order_by(asc: :inserted_at)
    |> limit(^limit)
  end

  def query(queryable, _) do
    queryable
  end

  def publish_conversation_change(conversation) do
    Absinthe.Subscription.publish(
      ChatWeb.Endpoint,
      conversation,
      conversation_change: conversation.id
    )
  end
end
