defmodule Chat.Factory do
  use ExMachina.Ecto, repo: Chat.Repo
  alias Chat.Users.User

  def user_factory do
    %User{
      email: Faker.Internet.email(),
      password: "password"
    }
  end
end
