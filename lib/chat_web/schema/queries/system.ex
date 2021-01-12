defmodule ChatWeb.Schema.Queries.System do
  use Absinthe.Schema.Notation
  alias ChatWeb.Schema.Resolvers
  object :system_queries do
    @desc "Gets all messages of a conversation"
    field :messages, list_of(:message) do
      arg(:conversation_id, non_null(:id))
      resolve(&Resolvers.System.list_chat_messages/3)
    end

    @desc "Gets all Conversations"
    field :conversations, list_of(:conversation) do
      resolve(&Resolvers.System.list_conversations/3)
    end
  end
end
