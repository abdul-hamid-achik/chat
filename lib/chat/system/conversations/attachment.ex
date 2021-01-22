defmodule Chat.System.Attachment do
  use Ecto.Schema

  import Ecto.Changeset
  alias Chat.System.Conversation
  alias Chat.Users.User

  @required [
    :title,
    :url,
    :user_id,
    :conversation_id
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          url: String.t(),
          user: User.t(),
          conversation: Conversation.t()
        }

  schema "attachments" do
    field :title, :string
    field :url, :string

    belongs_to :user, User
    belongs_to :conversation, Conversation

    timestamps()
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(attachment, attrs \\ %{}) do
    attachment
    |> cast(attrs, @required)
    |> validate_required(@required)
  end

  @spec build_upload_path(map()) :: String.t()
  def build_upload_path(params),
    do: "/#{params.conversation_id}/#{params.user_id}/#{params.attachment.filename}"
end
