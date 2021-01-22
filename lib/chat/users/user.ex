defmodule Chat.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @type t :: %__MODULE__{
          email: String.t()
        }

  schema "users" do
    pow_user_fields()
    has_many :conversations, Chat.System.ConversationMember
    timestamps()
  end
end
