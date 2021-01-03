defmodule ChatWeb.Schema.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  alias ChatWeb.Resolvers
  alias ChatWeb.Schema.Middleware

  query do
    @desc "Get all messages"
    field :messages, list_of(:message) do
      resolve(&Resolvers.System.list_chat_messages/3)
    end

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

  mutation do
    @desc "Create Account"
    field :signup, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))

      resolve(&Resolvers.Account.signup/3)
    end

    @desc "Log In Account"
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Account.login/3)
    end

    @desc "Create Message"
    field :create_message, :message do
      arg(:creator_id, non_null(:id))
      arg(:content, non_null(:string))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.System.create_message/3)
    end
  end

  object :message do
    field(:id, :id)
    field(:message, :string)
  end

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:password, :string)
  end

  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end
end
