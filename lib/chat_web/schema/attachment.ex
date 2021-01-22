defmodule ChatWeb.Schema.Attachment do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Chat.{System, Users}

  object :attachment do
    field :id, :id
    field :title, :string
    field :url, :string
    field :inserted_at, :naive_datetime
    field :user, non_null(:user), resolve: dataloader(Users)
    field :conversation, non_null(:conversation), resolve: dataloader(System)
  end
end
