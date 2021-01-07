defmodule Chat.System.Emojis do
  @moduledoc """
    Emojis context
  """

  import Ecto.Query, warn: false
  alias Chat.Repo
  alias Chat.System.Emoji

  @doc """
  Returns the list of chats.

  ## Examples

      iex> lists()
      [%Emoji{}, ...]

  """
  def lists do
    Repo.all(Emoji)
  end

  @doc """
  Gets a single emoji.

  Raises `Ecto.NoResultsError` if the Emoji does not exist.

  ## Examples

      iex> get!(123)
      %Emoji{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Emoji, id)

  @doc """
  Creates a emoji.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Emoji{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Emoji{}
    |> Emoji.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a emoji.

  ## Examples

      iex> update(emoji, %{field: new_value})
      {:ok, %Emoji{}}

      iex> update(emoji, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Emoji{} = emoji, attrs) do
    emoji
    |> Emoji.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a emoji.

  ## Examples

      iex> delete(emoji)
      {:ok, %Emoji{}}

      iex> delete(emoji)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Emoji{} = emoji) do
    Repo.delete(emoji)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking emoji changes.

  ## Examples

      iex> change(emoji)
      %Ecto.Changeset{data: %Emoji{}}

  """
  def change(%Emoji{} = emoji, attrs \\ %{}) do
    Emoji.changeset(emoji, attrs)
  end
end
