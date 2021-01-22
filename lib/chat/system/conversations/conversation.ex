defmodule Chat.System.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.System.{Message, ConversationMember}

  @type t :: %__MODULE__{
          title: String.t()
        }

  schema "conversations" do
    field :title, :string
    has_many :members, ConversationMember
    has_many :messages, Message
    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
