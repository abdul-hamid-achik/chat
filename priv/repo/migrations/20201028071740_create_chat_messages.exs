defmodule Chat.Repo.Migrations.CreateChatMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :conversation_id, references(:conversations, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:messages, [:conversation_id])
    create index(:messages, [:user_id])
  end
end
