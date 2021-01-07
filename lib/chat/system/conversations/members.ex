defmodule Chat.System.Conversations.Members do
  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.System.ConversationMember

  @doc """
  Returns the list of conversation_members.

  ## Examples

      iex> list()
      [%ConversationMember{}, ...]

  """
  def list do
    Repo.all(ConversationMember)
  end

  @doc """
  Gets a single conversation_member.

  Raises `Ecto.NoResultsError` if the Conversation member does not exist.

  ## Examples

      iex> get!(123)
      %ConversationMember{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(ConversationMember, id)

  @doc """
  Creates a conversation_member.

  ## Examples

      iex> create(%{field: value})
      {:ok, %ConversationMember{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %ConversationMember{}
    |> ConversationMember.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversation_member.

  ## Examples

      iex> update(conversation_member, %{field: new_value})
      {:ok, %ConversationMember{}}

      iex> update(conversation_member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%ConversationMember{} = conversation_member, attrs) do
    conversation_member
    |> ConversationMember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a conversation_member.

  ## Examples

      iex> delete(conversation_member)
      {:ok, %ConversationMember{}}

      iex> delete(conversation_member)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%ConversationMember{} = conversation_member) do
    Repo.delete(conversation_member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversation_member changes.

  ## Examples

      iex> change(conversation_member)
      %Ecto.Changeset{data: %ConversationMember{}}

  """
  def change(%ConversationMember{} = conversation_member, attrs \\ %{}) do
    ConversationMember.changeset(conversation_member, attrs)
  end
end
