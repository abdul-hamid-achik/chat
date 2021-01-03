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
end
