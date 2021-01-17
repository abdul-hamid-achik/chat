defmodule ChatWeb.Schema.Mutations.UserTest do
  use ChatWeb.ConnCase
  import Chat.Factory

  @sign_up_mutation """
  mutation SignUpMutation(
    $email: String!
    $password: String!
    $password_confirmation: String!
  ) {
    signUp(
      email: $email
      password: $password
      password_confirmation: $password_confirmation
    ) {
      token
      user {
        id
        email
      }
    }
  }
  """

  @login_mutation """
  mutation LoginMutation($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      token
      user {
        id
        email
      }
    }
  }
  """

  setup do
    conn = build_conn()
    [conn: conn]
  end

  describe "`sign_up` mutation" do
    test "should return token and user info", %{conn: conn} do
      assert %{
               "data" => %{
                 "signUp" => %{
                   "token" => token,
                   "user" => %{"email" => email, "id" => id}
                 }
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @sign_up_mutation,
                 "variables" => %{
                   email: "abdulachik@gmail.com",
                   password: "password",
                   password_confirmation: "password"
                 }
               })
               |> json_response(200)

      user = Chat.Users.get!(id)

      assert "#{user.id}" == id
      assert user.email == email
      assert ChatWeb.AuthToken.verify(token)
    end
  end

  describe "`login` mutation" do
    test "should return token and user info", %{conn: conn} do
      user =
        insert(:user,
          email: "abdulachik@gmail.com",
          password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
        )

      assert %{
               "data" => %{
                 "login" => %{
                   "token" => token,
                   "user" => %{"email" => email, "id" => id}
                 }
               }
             } =
               conn
               |> post("/api/graphql", %{
                 "query" => @login_mutation,
                 "variables" => %{
                   email: "abdulachik@gmail.com",
                   password: "password"
                 }
               })
               |> json_response(200)

      assert "#{user.id}" == id
      assert user.email == email
      assert ChatWeb.AuthToken.verify(token)
    end
  end
end
