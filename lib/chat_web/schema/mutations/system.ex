defmodule ChatWeb.Schema.Mutations.System do
  use Absinthe.Schema.Notation
  alias ChatWeb.Schema.{Middleware, Resolvers}

  object :system_mutations do
    @desc "Create Message"
    field :create_message, :message do
      arg(:content, non_null(:string))
      arg(:conversation_id, non_null(:string))

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
end
