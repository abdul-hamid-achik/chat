defmodule Chat.System.Conversations do
  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.System.Conversation

  @doc """
  Returns the list of conversations.

  ## Examples

      iex> list()
      [%Conversation{}, ...]

  """
  def list do
    Repo.all(Conversation)
  end

  @doc """
  Gets a single conversation.

  Raises `Ecto.NoResultsError` if the Conversation does not exist.

  ## Examples

      iex> get!(123)
      %Conversation{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Conversation, id)

  @doc """
  Creates a conversation.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Conversation{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversation.

  ## Examples

      iex> update(conversation, %{field: new_value})
      {:ok, %Conversation{}}

      iex> update(conversation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a conversation.

  ## Examples

      iex> delete(conversation)
      {:ok, %Conversation{}}

      iex> delete(conversation)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Conversation{} = conversation) do
    Repo.delete(conversation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversation changes.

  ## Examples

      iex> change(conversation)
      %Ecto.Changeset{data: %Conversation{}}

  """
  def change(%Conversation{} = conversation, attrs \\ %{}) do
    Conversation.changeset(conversation, attrs)
  end
end
