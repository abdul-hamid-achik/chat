defmodule Chat.Repo.Migrations.CreateChatMessageReactions do
  use Ecto.Migration

  def change do
    create table(:message_reactions) do
      add :message_id, references(:messages, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :emoji_id, references(:emojis, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:message_reactions, [:message_id])
    create index(:message_reactions, [:user_id])
    create index(:message_reactions, [:emoji_id])
    create unique_index(:message_reactions, [:user_id, :message_id, :emoji_id])
  end
end
