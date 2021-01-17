defmodule ChatWeb.Schema.Schema do
  use Absinthe.Schema
  alias Chat.{Users, System}

  import_types(Absinthe.Type.Custom)
  import_types(ChatWeb.Schema.Message)
  import_types(ChatWeb.Schema.Conversation)
  import_types(ChatWeb.Schema.ConversationMember)
  import_types(ChatWeb.Schema.User)

  import_types(ChatWeb.Schema.Queries.User)
  import_types(ChatWeb.Schema.Queries.System)

  import_types(ChatWeb.Schema.Mutations.User)
  import_types(ChatWeb.Schema.Mutations.System)

  import_types(ChatWeb.Schema.Subscriptions.System)

  query do
    import_fields(:user_queries)
    import_fields(:system_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:system_mutations)
  end

  subscription do
    import_fields(:system_subscriptions)
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
