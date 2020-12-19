defmodule ChatWeb.Schema do
  use Absinthe.Schema
  import_types(ChatWeb.Schema.Messages)

  alias ChatWeb.Resolvers

  query do
    @desc "Get all messages"
    field :messages, list_of(:message) do
      resolve(&Resolvers.Message.list_chat_messages/3)
    end
  end
end
