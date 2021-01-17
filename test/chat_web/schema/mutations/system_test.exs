defmodule ChatWeb.Schema.Mutations.SystemTest do
  use ChatWeb.ConnCase
  import Chat.Factory

  @create_conversation_mutation """
  mutation CreateConversationMutation($title: String!) {
    createConversation(title: $title) {
      id
      title
    }
  }
  """

  @create_message_mutation """
  mutation CreateMessageMutation($content: String!, $conversation_id: Number!) {
    createMessage(content: $content, conversation_id: $conversation_id) {
      id
      content
      user {
        email
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

    token = ChatWeb.AuthToken.sign(user)
    conn = build_conn()
    auth_conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer #{token}")
    [conn: conn, auth_conn: auth_conn, user: user, token: token]
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
end
