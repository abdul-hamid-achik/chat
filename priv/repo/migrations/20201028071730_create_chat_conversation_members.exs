defmodule Chat.Repo.Migrations.CreateChatConversationMembers do
  use Ecto.Migration

  def change do
    create table(:conversation_members) do
      add :owner, :boolean, default: false, null: false
      add :conversation_id, references(:conversations, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:conversation_members, [:conversation_id])
    create index(:conversation_members, [:user_id])
  end
end
