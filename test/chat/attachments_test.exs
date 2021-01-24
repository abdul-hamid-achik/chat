defmodule Chat.System.AttachmentsTest do
  use Chat.DataCase
  import Chat.Factory
  use Mimic

  alias Chat.System.Attachments

  setup :verify_on_exit!

  setup do
    user =
      insert(:user,
        email: "abdulachik@gmail.com",
        password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
      )

    conversation =
      insert(:conversation,
        title: "Random Title"
      )

    insert(:conversation_member, conversation: conversation, user: user, owner: true)
    [conversation: conversation, user: user]
  end

  describe "`create/2`" do
    test "should upload attachment to the bucket", %{conversation: conversation, user: user} do
      expect(ExAws, :request!, fn _ -> :ok end)

      params = %{
        attachment: %Plug.Upload{
          content_type: "image/png",
          filename: "image.png",
          path: "test/fixtures/image.png"
        },
        conversation_id: conversation.id,
        user_id: user.id
      }

      assert {:ok, attachment} = Attachments.create(params)
      assert attachment.conversation_id == conversation.id
      assert attachment.user_id == user.id

      assert attachment.url =~
               "/uploads/#{conversation.id}/#{user.id}/#{params.attachment.filename}"
    end
  end
end
