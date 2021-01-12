defmodule ChatWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation
  alias ChatWeb.Schema.Resolvers

  object :user_mutations do
    @desc "Create Account"
    field :sign_up, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))

      resolve(&Resolvers.Account.sign_up/3)
    end

    @desc "Log In Account"
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Account.login/3)
    end
  end
end
