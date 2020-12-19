defmodule ChatWeb.Schema.Messages do
  use Absinthe.Schema.Notation

  object :message do
    field :id, :id
    field :message, :string
  end
end
