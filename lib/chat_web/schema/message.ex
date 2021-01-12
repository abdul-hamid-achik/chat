defmodule ChatWeb.Schema.Message do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Chat.Users

  object :message do
    field :id, :id
    field :content, non_null(:string)
    field :conversation, :conversation
    field :user, non_null(:user), resolve: dataloader(Users)
    field :inserted_at, :naive_datetime
  end
end
