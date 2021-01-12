defmodule ChatWeb.Schema.Conversation do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 3]
  alias Chat.System

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
end
