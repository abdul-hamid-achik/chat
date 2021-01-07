defmodule Chat.System.Messages.Seens do
  @moduledoc """
  Seen Messages Context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.System.SeenMessage

  @doc """
  Returns the list of seen messages.

  ## Examples

      iex> list()
      [%SeenMessage{}, ...]

  """
  def lisst do
    Repo.all(SeenMessage)
  end

  @doc """
  Gets a single seen_message.

  Raises `Ecto.NoResultsError` if the Seen message does not exist.

  ## Examples

      iex> get!(123)
      %SeenMessage{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(SeenMessage, id)

  @doc """
  Creates a seen_message.

  ## Examples

      iex> create(%{field: value})
      {:ok, %SeenMessage{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %SeenMessage{}
    |> SeenMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a seen_message.

  ## Examples

      iex> update(seen_message, %{field: new_value})
      {:ok, %SeenMessage{}}

      iex> update(seen_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%SeenMessage{} = seen_message, attrs) do
    seen_message
    |> SeenMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a seen_message.

  ## Examples

      iex> delete(seen_message)
      {:ok, %SeenMessage{}}

      iex> delete(seen_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%SeenMessage{} = seen_message) do
    Repo.delete(seen_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seen_message changes.

  ## Examples

      iex> change(seen_message)
      %Ecto.Changeset{data: %SeenMessage{}}

  """
  def change(%SeenMessage{} = seen_message, attrs \\ %{}) do
    SeenMessage.changeset(seen_message, attrs)
  end
end
