defmodule Chat.Users do
  import Ecto.Query, warn: false

  use Pow.Ecto.Context,
    repo: Chat.Repo,
    user: Chat.Users.User

  alias Chat.Repo
  alias Chat.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list()
      [%User{}, ...]

  """
  def list do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get!(123)
      %User{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: pow_get_by(id: id)

  @doc """
  Creates a user.

  ## Examples

      iex> create(%{field: value})
      {:ok, %User{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    pow_create(attrs)
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%User{} = user, attrs) do
    pow_update(user, attrs)
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete(user)
      {:ok, %User{}}

      iex> delete(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%User{} = user) do
    pow_delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Authenticates a user.

  Returns `{:ok, user}` if a user exists with the given username
  and the password is valid. Otherwise, `:error` is returned.
  """
  def authenticate(email, password) do
    with %User{} = user <- Repo.get_by(User, email: email) do
      case user.__struct__.verify_password(user, password) do
        true -> {:ok, user}
        _ -> :error
      end
    else
      _ -> :error
    end
  end

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(User, %{limit: limit}) do
    Message
    |> order_by(asc: :inserted_at)
    |> limit(^limit)
  end

  def query(queryable, _) do
    queryable
  end
end
