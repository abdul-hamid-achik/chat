defmodule Chat.Factory do
  use ExMachina.Ecto, repo: Chat.Repo
  alias Chat.Users.User
  alias Chat.System.{Message, Conversation, ConversationMember}

  def user_factory do
    %User{
      email: Faker.Internet.email(),
      password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
    }
  end

  def message_factory do
    %Message{
      content: Faker.Lorem.paragraph(2),
      user: build(:user)
    }
  end

  def conversation_factory do
    %Conversation{
      title: Faker.Lorem.sentence()
    }
  end

  def conversation_member_factory do
    %ConversationMember{
      conversation: build(:conversation),
      user: build(:user)
    }
  end
end
