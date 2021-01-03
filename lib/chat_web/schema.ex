defmodule ChatWeb.Schema do
  use Absinthe.Schema
  import_types(ChatWeb.Schema.Messages)
  import_types(ChatWeb.Schema.User)

  alias ChatWeb.Resolvers

  query do
    @desc "Get all messages"
    field :messages, list_of(:message) do
      resolve(&Resolvers.Message.list_chat_messages/3)
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.User.list_users/3)
    end
  end

  mutation do
    @desc "sign up"
    field :signup, type: :user do
      # arg(:email, not_null(:string))
      # arg(:password, not_null(:string))
      # arg(:password_confirmation, not_null(:string))

      resolve(&Resolvers.User.signup/3)
    end
  end
end
