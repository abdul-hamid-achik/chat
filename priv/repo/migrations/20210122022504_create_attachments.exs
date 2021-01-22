defmodule Chat.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :title, :string, null: false
      add :url, :string, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :conversation_id, references(:conversations, on_delete: :nothing), null: false
      timestamps()
    end

    create unique_index(:attachments, [:user_id, :title, :conversation_id])
    create unique_index(:attachments, [:url])
  end
end
