defmodule ChatWeb.Schema.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  import_types(Absinthe.Type.Custom)

  alias ChatWeb.Resolvers
  alias ChatWeb.Schema.Middleware
  alias Chat.{Users, System}

  query do
    @desc "Get all messages"
    field :messages, list_of(:message) do
      arg(:conversation_id, non_null(:id))
      resolve(&Resolvers.System.list_chat_messages/3)
    end

    field :conversations, list_of(:conversation) do
      resolve(&Resolvers.System.list_conversations/3)
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
      arg(:content, non_null(:string))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.System.create_message/3)
    end

    @desc "Create Conversation"
    field :create_conversation, :conversation do
      arg(:title, non_null(:string))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.System.create_conversation/3)
    end
  end

  object :conversation_member do
    field :id, :id
    field :user, non_null(:user), resolve: dataloader(Users)
    field :conversation, non_null(:conversation), resolve: dataloader(System)
    field :owner, :boolean
  end

  object :conversation do
    field :id, :id
    field :title, :string
    field :inserted_at, :naive_datetime

    field :members, list_of(:conversation_member) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(System, :members, []))
    end

    field :messages, list_of(:message) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(System, :messages, []))
    end
  end

  object :message do
    field :id, :id
    field :content, non_null(:string)
    field :user, non_null(:user), resolve: dataloader(Users)
    field :inserted_at, :naive_datetime
  end

  object :user do
    field :id, :id
    field :email, :string
    field :password, :string
  end

  object :session do
    field :user, non_null(:user), resolve: dataloader(Users)
    field :token, non_null(:string)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Users, Users.datasource())
      |> Dataloader.add_source(System, System.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
