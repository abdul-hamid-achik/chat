defmodule ChatWeb.Schema.User do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Chat.Users

  object :user do
    field :id, :id
    field :email, :string
    field :password, :string
  end

  object :session do
    field :user, non_null(:user), resolve: dataloader(Users)
    field :token, non_null(:string)
  end
end
