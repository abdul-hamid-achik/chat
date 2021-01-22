defmodule ChatWeb.Schema.Mutations.SystemTest do
  import Chat.Factory
  use ChatWeb.ConnCase
  use Mimic

  @create_conversation_mutation """
  mutation CreateConversationMutation($title: String!) {
    createConversation(title: $title) {
      id
      title
    }
  }
  """

  @create_message_mutation """
  mutation CreateMessageMutation($content: String!, $conversation_id: ID!) {
    createMessage(content: $content, conversation_id: $conversation_id) {
      id
      content
      user {
        email
      }
    }
  }
  """

  @create_attachment_mutation """
  mutation CreateAttachmentMutation($title: String!, $conversation_id: ID!) {
    createAttachment(title: $title, conversation_id: $conversation_id, attachment: "attachment") {
      id
      title
      url
      conversation {
        id
      }
      user {
        email
      }
    }
  }
  """

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

    token = ChatWeb.AuthToken.sign(user)
    conn = build_conn()
    auth_conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer #{token}")
    [conn: conn, auth_conn: auth_conn, user: user, token: token, conversation: conversation]
  end

  describe "`create_conversation` mutation" do
    test "should create a conversation for logged user", %{auth_conn: conn, user: user} do
      title = "Random Title"

      assert %{
               "data" => %{
                 "createConversation" => %{"id" => conversation_id, "title" => conversation_title}
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @create_conversation_mutation,
                 "variables" => %{title: title}
               })
               |> json_response(200)

      conversation = Chat.System.get_conversation!(conversation_id)

      assert title == conversation_title
      assert "#{conversation.id}" == conversation_id
      assert conversation.title == conversation_title

      conversation
      |> Chat.Repo.preload(:members)
      |> Map.get(:members)
      |> Enum.each(&assert &1.user_id == user.id)
    end
  end

  describe "`create_message` mutation" do
    test "should create a conversation for logged user", %{
      auth_conn: conn,
      conversation: conversation
    } do
      content = "Random Message"

      assert %{
               "data" => %{
                 "createMessage" => %{
                   "id" => message_id,
                   "content" => message_content,
                   "user" => %{
                     "email" => _user_email
                   }
                 }
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @create_message_mutation,
                 "variables" => %{content: content, conversation_id: "#{conversation.id}"}
               })
               |> json_response(200)

      message = Chat.System.get_message!(message_id)
      assert "#{message.id}" == message_id
      assert content == message_content
      assert message.content == message_content

      conversation
      |> Chat.Repo.preload(:messages)
      |> Map.get(:messages)
      |> Enum.each(&assert &1.content == message_content)
    end
  end

  describe "`create_attachment` mutation" do
    test "should upload file and create attachment in conversation", %{
      auth_conn: conn,
      conversation: conversation,
      user: user
    } do
      expect(ExAws, :request!, fn _ -> :ok end)

      title = "My new Image"

      upload = %Plug.Upload{
        content_type: "image/png",
        filename: "image.png",
        path: "test/fixtures/image.png"
      }

      assert %{
               "data" => %{
                 "createAttachment" => %{
                   "id" => attachment_id,
                   "title" => attachment_title,
                   "url" => attachment_url,
                   "user" => %{
                     "email" => user_email
                   },
                   "conversation" => %{
                     "id" => conversation_id
                   }
                 }
               }
             } =
               conn
               |> put_req_header("content-type", "multipart/form-data")
               |> post("/api/graphql", %{
                 "query" => @create_attachment_mutation,
                 "attachment" => upload,
                 "variables" => %{
                   title: title,
                   conversation_id: conversation.id
                 }
               })
               |> json_response(200)

      assert attachment = Chat.System.Attachments.get!(attachment_id)
      assert "#{attachment.id}" == attachment_id
      assert attachment.title == attachment_title
      assert attachment_url == attachment.url
      assert user.email == user_email
      assert "#{conversation.id}" == conversation_id
    end
  end
end
