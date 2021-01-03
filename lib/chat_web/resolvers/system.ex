defmodule ChatWeb.Resolvers.System do
  def list_chat_messages(_parent, _args, _resolution) do
    {:ok, Chat.System.list_chat_messages()}
  end

  def create_message(_, _, _) do
    {:ok, nil}
  end
end
