defmodule Chat.SystemTest do
  use Chat.DataCase

  alias Chat.System

  describe "chat_conversations" do
    alias Chat.System.Conversation

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def conversation_fixture(attrs \\ %{}) do
      {:ok, conversation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_conversation()

      conversation
    end

    test "list_chat_conversations/0 returns all chat_conversations" do
      conversation = conversation_fixture()
      assert System.list_chat_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert System.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      assert {:ok, %Conversation{} = conversation} = System.create_conversation(@valid_attrs)
      assert conversation.title == "some title"
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{} = conversation} = System.update_conversation(conversation, @update_attrs)
      assert conversation.title == "some updated title"
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_conversation(conversation, @invalid_attrs)
      assert conversation == System.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = System.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> System.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = System.change_conversation(conversation)
    end
  end

  describe "chat_conversation_members" do
    alias Chat.System.ConversationMember

    @valid_attrs %{owner: true}
    @update_attrs %{owner: false}
    @invalid_attrs %{owner: nil}

    def conversation_member_fixture(attrs \\ %{}) do
      {:ok, conversation_member} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_conversation_member()

      conversation_member
    end

    test "list_chat_conversation_members/0 returns all chat_conversation_members" do
      conversation_member = conversation_member_fixture()
      assert System.list_chat_conversation_members() == [conversation_member]
    end

    test "get_conversation_member!/1 returns the conversation_member with given id" do
      conversation_member = conversation_member_fixture()
      assert System.get_conversation_member!(conversation_member.id) == conversation_member
    end

    test "create_conversation_member/1 with valid data creates a conversation_member" do
      assert {:ok, %ConversationMember{} = conversation_member} = System.create_conversation_member(@valid_attrs)
      assert conversation_member.owner == true
    end

    test "create_conversation_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_conversation_member(@invalid_attrs)
    end

    test "update_conversation_member/2 with valid data updates the conversation_member" do
      conversation_member = conversation_member_fixture()
      assert {:ok, %ConversationMember{} = conversation_member} = System.update_conversation_member(conversation_member, @update_attrs)
      assert conversation_member.owner == false
    end

    test "update_conversation_member/2 with invalid data returns error changeset" do
      conversation_member = conversation_member_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_conversation_member(conversation_member, @invalid_attrs)
      assert conversation_member == System.get_conversation_member!(conversation_member.id)
    end

    test "delete_conversation_member/1 deletes the conversation_member" do
      conversation_member = conversation_member_fixture()
      assert {:ok, %ConversationMember{}} = System.delete_conversation_member(conversation_member)
      assert_raise Ecto.NoResultsError, fn -> System.get_conversation_member!(conversation_member.id) end
    end

    test "change_conversation_member/1 returns a conversation_member changeset" do
      conversation_member = conversation_member_fixture()
      assert %Ecto.Changeset{} = System.change_conversation_member(conversation_member)
    end
  end

  describe "chat_messages" do
    alias Chat.System.Message

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_message()

      message
    end

    test "list_chat_messages/0 returns all chat_messages" do
      message = message_fixture()
      assert System.list_chat_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert System.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = System.create_message(@valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = System.update_message(message, @update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_message(message, @invalid_attrs)
      assert message == System.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = System.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> System.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = System.change_message(message)
    end
  end

  describe "chat_emojis" do
    alias Chat.System.Emoji

    @valid_attrs %{key: "some key", unicode: "some unicode"}
    @update_attrs %{key: "some updated key", unicode: "some updated unicode"}
    @invalid_attrs %{key: nil, unicode: nil}

    def emoji_fixture(attrs \\ %{}) do
      {:ok, emoji} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_emoji()

      emoji
    end

    test "list_chat_emojis/0 returns all chat_emojis" do
      emoji = emoji_fixture()
      assert System.list_chat_emojis() == [emoji]
    end

    test "get_emoji!/1 returns the emoji with given id" do
      emoji = emoji_fixture()
      assert System.get_emoji!(emoji.id) == emoji
    end

    test "create_emoji/1 with valid data creates a emoji" do
      assert {:ok, %Emoji{} = emoji} = System.create_emoji(@valid_attrs)
      assert emoji.key == "some key"
      assert emoji.unicode == "some unicode"
    end

    test "create_emoji/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_emoji(@invalid_attrs)
    end

    test "update_emoji/2 with valid data updates the emoji" do
      emoji = emoji_fixture()
      assert {:ok, %Emoji{} = emoji} = System.update_emoji(emoji, @update_attrs)
      assert emoji.key == "some updated key"
      assert emoji.unicode == "some updated unicode"
    end

    test "update_emoji/2 with invalid data returns error changeset" do
      emoji = emoji_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_emoji(emoji, @invalid_attrs)
      assert emoji == System.get_emoji!(emoji.id)
    end

    test "delete_emoji/1 deletes the emoji" do
      emoji = emoji_fixture()
      assert {:ok, %Emoji{}} = System.delete_emoji(emoji)
      assert_raise Ecto.NoResultsError, fn -> System.get_emoji!(emoji.id) end
    end

    test "change_emoji/1 returns a emoji changeset" do
      emoji = emoji_fixture()
      assert %Ecto.Changeset{} = System.change_emoji(emoji)
    end
  end

  describe "chat_message_reactions" do
    alias Chat.System.MessageReaction

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def message_reaction_fixture(attrs \\ %{}) do
      {:ok, message_reaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_message_reaction()

      message_reaction
    end

    test "list_chat_message_reactions/0 returns all chat_message_reactions" do
      message_reaction = message_reaction_fixture()
      assert System.list_chat_message_reactions() == [message_reaction]
    end

    test "get_message_reaction!/1 returns the message_reaction with given id" do
      message_reaction = message_reaction_fixture()
      assert System.get_message_reaction!(message_reaction.id) == message_reaction
    end

    test "create_message_reaction/1 with valid data creates a message_reaction" do
      assert {:ok, %MessageReaction{} = message_reaction} = System.create_message_reaction(@valid_attrs)
    end

    test "create_message_reaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_message_reaction(@invalid_attrs)
    end

    test "update_message_reaction/2 with valid data updates the message_reaction" do
      message_reaction = message_reaction_fixture()
      assert {:ok, %MessageReaction{} = message_reaction} = System.update_message_reaction(message_reaction, @update_attrs)
    end

    test "update_message_reaction/2 with invalid data returns error changeset" do
      message_reaction = message_reaction_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_message_reaction(message_reaction, @invalid_attrs)
      assert message_reaction == System.get_message_reaction!(message_reaction.id)
    end

    test "delete_message_reaction/1 deletes the message_reaction" do
      message_reaction = message_reaction_fixture()
      assert {:ok, %MessageReaction{}} = System.delete_message_reaction(message_reaction)
      assert_raise Ecto.NoResultsError, fn -> System.get_message_reaction!(message_reaction.id) end
    end

    test "change_message_reaction/1 returns a message_reaction changeset" do
      message_reaction = message_reaction_fixture()
      assert %Ecto.Changeset{} = System.change_message_reaction(message_reaction)
    end
  end

  describe "chat_seen_messages" do
    alias Chat.System.SeenMessage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def seen_message_fixture(attrs \\ %{}) do
      {:ok, seen_message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_seen_message()

      seen_message
    end

    test "list_chat_seen_messages/0 returns all chat_seen_messages" do
      seen_message = seen_message_fixture()
      assert System.list_chat_seen_messages() == [seen_message]
    end

    test "get_seen_message!/1 returns the seen_message with given id" do
      seen_message = seen_message_fixture()
      assert System.get_seen_message!(seen_message.id) == seen_message
    end

    test "create_seen_message/1 with valid data creates a seen_message" do
      assert {:ok, %SeenMessage{} = seen_message} = System.create_seen_message(@valid_attrs)
    end

    test "create_seen_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_seen_message(@invalid_attrs)
    end

    test "update_seen_message/2 with valid data updates the seen_message" do
      seen_message = seen_message_fixture()
      assert {:ok, %SeenMessage{} = seen_message} = System.update_seen_message(seen_message, @update_attrs)
    end

    test "update_seen_message/2 with invalid data returns error changeset" do
      seen_message = seen_message_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_seen_message(seen_message, @invalid_attrs)
      assert seen_message == System.get_seen_message!(seen_message.id)
    end

    test "delete_seen_message/1 deletes the seen_message" do
      seen_message = seen_message_fixture()
      assert {:ok, %SeenMessage{}} = System.delete_seen_message(seen_message)
      assert_raise Ecto.NoResultsError, fn -> System.get_seen_message!(seen_message.id) end
    end

    test "change_seen_message/1 returns a seen_message changeset" do
      seen_message = seen_message_fixture()
      assert %Ecto.Changeset{} = System.change_seen_message(seen_message)
    end
  end
end
