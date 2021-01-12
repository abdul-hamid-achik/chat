defmodule ChatWeb.Schema.Resolvers.Account do
  alias Chat.Users, as: Accounts
  alias ChatWeb.Schema.ChangesetErrors

  def list_users(_parent, _args, _resolution) do
    {:ok, Chat.Users.list()}
  end

  def login(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      :error ->
        {:error, "Whoops, invalid credentials!"}

      {:ok, user} ->
        token = ChatWeb.AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def sign_up(_, args, _) do
    case Accounts.create(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = ChatWeb.AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end
