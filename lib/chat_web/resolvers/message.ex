defmodule ChatWeb.Resolvers.Message do
  def list_chat_messages(_parent, _args, _resolution) do
    {:ok, Chat.System.list_chat_messages()}
  end
end
