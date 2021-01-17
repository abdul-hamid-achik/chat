defmodule ChatWeb.Schema.Queries.SystemTest do
  use ChatWeb.ConnCase

  import Chat.Factory

  @messages_query """
  query Messages($conversation_id: ID!) {
    messages(conversation_id: $conversation_id) {
      id
      content
      insertedAt
      user {
        email
      }
    }
  }
  """

  @conversations_query """
  query Conversations {
    conversations {
      id
      title
      messages {
        id
        insertedAt
      }
    }
  }
  """

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

    message = insert(:message, conversation: conversation, user: user)

    token = ChatWeb.AuthToken.sign(user)
    conn = build_conn()
    auth_conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer #{token}")

    [
      conn: conn,
      auth_conn: auth_conn,
      user: user,
      message: message,
      token: token,
      conversation: conversation
    ]
  end

  describe "`messages` Query" do
    test "should return data when logged in", %{
      auth_conn: conn,
      user: user,
      conversation: conversation,
      message: message
    } do
      assert %{
               "data" => %{
                 "messages" => [
                   %{
                     "content" => message_content,
                     "id" => message_id,
                     "insertedAt" => _message_inserted_at,
                     "user" => %{"email" => user_email}
                   }
                 ]
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @messages_query,
                 "variables" => %{conversation_id: conversation.id}
               })
               |> json_response(200)

      assert message_content == message.content
      assert message_id == "#{message.id}"
      assert user_email == user.email
    end

    test "shouldn't return data when not logged in", %{conn: conn, conversation: conversation} do
      assert %{
               "data" => %{"messages" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "Please sign in first!",
                   "path" => ["messages"]
                 }
               ]
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @messages_query,
                 "variables" => %{conversation_id: conversation.id}
               })
               |> json_response(200)
    end
  end

  describe "`conversations` Query" do
    test "should return data when logged in", %{
      auth_conn: conn,
      conversation: conversation,
      message: message
    } do
      assert %{
               "data" => %{
                 "conversations" => [
                   %{
                     "id" => conversation_id,
                     "messages" => [
                       %{
                         "id" => message_id,
                         "insertedAt" => _message_inserted_at
                       }
                     ],
                     "title" => conversation_title
                   }
                 ]
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @conversations_query,
                 "variables" => %{}
               })
               |> json_response(200)

      assert conversation_id == "#{conversation.id}"
      assert conversation_title == "#{conversation.title}"
      assert message_id == "#{message.id}"
    end

    test "shouldn't return data when not logged in", %{
      conn: conn
    } do
      assert %{
               "data" => %{
                 "conversations" => nil
               },
               "errors" => [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "Please sign in first!",
                   "path" => ["conversations"]
                 }
               ]
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @conversations_query,
                 "variables" => %{}
               })
               |> json_response(200)
    end
  end
end
