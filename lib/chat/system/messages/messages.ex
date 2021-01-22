defmodule Chat.System.Messages do
  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.{System, System.Message}

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list()
      [%Message{}, ...]

  """
  def list(nil), do: []

  def list(conversation_id) do
    query =
      from m in Message,
        where: m.conversation_id == ^conversation_id

    Repo.all(query)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get!(123)
      %Message{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Message{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    with {:ok, message} <-
           %Message{}
           |> Message.changeset(attrs)
           |> Repo.insert(),
         conversation_id <- Map.get(attrs, :conversation_id),
         conversation <- System.get_conversation!(conversation_id),
         :ok <- System.publish_conversation_change(conversation) do
      {:ok, message}
    else
      error -> error
    end
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete(message)
      {:ok, %Message{}}

      iex> delete(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
