defmodule Chat.System.Attachment do
  use Ecto.Schema

  import Ecto.Changeset
  alias Chat.System.Conversation
  alias Chat.Users.User

  @required [
    :url,
    :user_id,
    :conversation_id
  ]

  @type t :: %__MODULE__{
          url: String.t(),
          user: User.t(),
          conversation: Conversation.t()
        }

  schema "attachments" do
    field :url, :string

    belongs_to :user, User
    belongs_to :conversation, Conversation

    timestamps()
  end

  def changeset(attachment, attrs) do
    attachment
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> cast_assoc(:user)
    |> cast_assoc(:conversation)
    |> unique_constraint(:url)
  end

  @spec build_upload_path(map()) :: String.t()
  def build_upload_path(params),
    do: "/#{params.conversation_id}/#{params.user_id}/#{params.attachment.filename}"
end
