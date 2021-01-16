defmodule ChatWeb.Schema.Queries.UserTest do
  use ChatWeb.ConnCase

  import Chat.Factory

  @user_query """
  query getUserInfo {
    me {
      id
      email
    }
  }
  """

  setup do
    conn = build_conn()
    [conn: conn]
  end

  # url = ChatWeb.Router.Helpers.api_v1_session_path(conn, :create)
  # conn = post(conn, url, user: @valid_attributes)

  # assert %{
  #          "data" => %{
  #            "access_token" => _access_token,
  #            "renewal_token" => _renewal_token
  #          }
  #        } = json_response(conn, 200)

  describe "`me` Query" do
    test "should return data when logged in", %{conn: conn} do
      user =
        insert(:user,
          email: "example@email.com",
          password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
        )

      token = ChatWeb.AuthToken.sign(user)

      assert %{
               "data" => %{"me" => %{"id" => user_id, "email" => user_email}}
             } =
               conn
               |> Plug.Conn.put_req_header("authorization", "Bearer #{token}")
               |> post("/api/graphql", %{
                 "query" => @user_query,
                 "variables" => %{id: user.id}
               })
               |> json_response(200)

      assert user.email == user_email
      assert "#{user.id}" == user_id
    end

    test "shouldn't return data when not logged in", %{conn: conn} do
      conn =
        post(conn, "/api/graphql", %{
          "query" => @user_query,
          "variables" => %{id: 1}
        })

      assert json_response(conn, 200) == %{
               "data" => %{"me" => nil}
             }
    end
  end
end
