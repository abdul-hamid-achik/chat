defmodule ChatWeb.SessionControllerTest do
  use ChatWeb.ConnCase

  @valid_attributes %{
    email: "example@email.com",
    password: "password"
  }

  setup do
    conn = build_conn()
    [conn: conn]
  end

  describe "create" do
    test "should return access_token and renewal_token when creating session", %{conn: conn} do
      url = ChatWeb.Router.Helpers.api_v1_session_path(conn, :create)
      conn = post(conn, url, user: @valid_attributes)

      assert %{
               "data" => %{
                 "access_token" => _access_token,
                 "renewal_token" => _renewal_token
               }
             } = json_response(conn, 200)
    end
  end
end
