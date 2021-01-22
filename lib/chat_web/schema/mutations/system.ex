defmodule ChatWeb.Schema.Mutations.System do
  use Absinthe.Schema.Notation

  import_types(Absinthe.Plug.Types)

  alias ChatWeb.Schema.{Middleware, Resolvers}

  object :system_mutations do
    @desc "Create Message"
    field :create_message, :message do
      arg(:content, non_null(:string))
      arg(:conversation_id, non_null(:id))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.System.create_message/3)
    end

    @desc "Create Conversation"
    field :create_conversation, :conversation do
      arg(:title, non_null(:string))

      middleware(Middleware.Authenticate)
      resolve(&Resolvers.System.create_conversation/3)
    end

    @desc "Create an attachment by Uploading a File to a conversation"
    field :create_attachment, :attachment do
      arg(:conversation_id, non_null(:id))
      arg(:title, non_null(:string))
      arg(:attachment, non_null(:upload))

      resolve(&Resolvers.System.create_attachment/3)
    end
  end
end
