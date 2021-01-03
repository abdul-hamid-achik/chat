defmodule ChatWeb.Resolvers.User do
  def list_users(_parent, _args, _resolution) do
    {:ok, Chat.Users.list()}
  end

  def signup(_parent, args, resolutions) do
    IO.inspect({args, resolutions})
    Chat.Users.create(args)
  end
end
