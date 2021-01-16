defmodule ChatWeb.Schema.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
    field :password, :string
  end

  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end
end
