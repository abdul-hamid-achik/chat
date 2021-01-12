defmodule ChatWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation
  alias ChatWeb.Schema.{Middleware, Resolvers}

  object :user_queries do
    @desc "Get all users"
    field :users, list_of(:user) do
      middleware(Middleware.Authenticate)
      resolve(&Resolvers.Account.list_users/3)
    end

    @desc "Get the currently signed-in user"
    field :me, :user do
      resolve(&Resolvers.Account.me/3)
    end
  end
end
