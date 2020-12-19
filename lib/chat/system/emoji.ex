defmodule Chat.System.Emoji do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emojis" do
    field :key, :string
    field :unicode, :string

    timestamps()
  end

  @doc false
  def changeset(emoji, attrs) do
    emoji
    |> cast(attrs, [:key, :unicode])
    |> validate_required([:key, :unicode])
  end
end
