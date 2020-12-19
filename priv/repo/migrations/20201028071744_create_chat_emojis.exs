defmodule Chat.Repo.Migrations.CreateChatEmojis do
  use Ecto.Migration

  def change do
    create table(:emojis) do
      add :key, :string, null: false
      add :unicode, :string, null: false
      timestamps()
    end

  end
end
