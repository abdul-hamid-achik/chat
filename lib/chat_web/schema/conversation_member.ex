defmodule ChatWeb.Schema.ConversationMember do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Chat.{System, Users}

  object :conversation_member do
    field :id, :id
    field :user, non_null(:user), resolve: dataloader(Users)
    field :conversation, non_null(:conversation), resolve: dataloader(System)
    field :owner, :boolean
  end
end
