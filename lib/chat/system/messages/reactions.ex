defmodule Chat.System.Messages.Reactions do
  @moduledoc """
  Message Reaction Context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.System.MessageReaction

  @doc """
  Returns the list of chats.

  ## Examples

      iex> list()
      [%MessageReaction{}, ...]

  """
  def list do
    Repo.all(MessageReaction)
  end

  @doc """
  Gets a single message_reaction.

  Raises `Ecto.NoResultsError` if the Message reaction does not exist.

  ## Examples

      iex> get!(123)
      %MessageReaction{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(MessageReaction, id)

  @doc """
  Creates a message_reaction.

  ## Examples

      iex> create(%{field: value})
      {:ok, %MessageReaction{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %MessageReaction{}
    |> MessageReaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message_reaction.

  ## Examples

      iex> update(message_reaction, %{field: new_value})
      {:ok, %MessageReaction{}}

      iex> update(message_reaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%MessageReaction{} = message_reaction, attrs) do
    message_reaction
    |> MessageReaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message_reaction.

  ## Examples

      iex> delete(message_reaction)
      {:ok, %MessageReaction{}}

      iex> delete(message_reaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%MessageReaction{} = message_reaction) do
    Repo.delete(message_reaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message_reaction changes.

  ## Examples

      iex> change(message_reaction)
      %Ecto.Changeset{data: %MessageReaction{}}

  """
  def change(%MessageReaction{} = message_reaction, attrs \\ %{}) do
    MessageReaction.changeset(message_reaction, attrs)
  end
end
