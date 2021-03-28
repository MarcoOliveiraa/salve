defmodule Salve.UsersTest do
  use Salve.DataCase

  alias Salve.Users

  alias Ecto.Changeset

  describe "Users" do
    alias Salve.Users.User

    @valid_params   %{name: "Some Name", email: "some@email.com", password: "Some Password", password_confirmation: "Some Password"}
    @updated_params %{id: 1, name: "Some Updated Name", email: "some_updated@email.com", password: "Some Updated Password", password_confirmation: "Some Updated Password"}
    @invalid_params %{name: "Some Name", email: "Some Email", password: "Some Password", password_confirmation: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_params)
        |> Users.create_user()

      user
    end

    test "create_user/1 when params is valid"do
      assert {:ok, %User{} = user} = Users.create_user(@valid_params)
      assert user.name == "Some Name"
      assert user.email == "some@email.com"
      assert user.password == "Some Password"
      assert user.password_confirmation == "Some Password"
    end

    test "create_user/1 when params is invalid" do
      assert {:error, %Changeset{}} = Users.create_user(@invalid_params)
    end


    test "update_user/2 when params is valid" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @updated_params)
      assert user.name == "Some Updated Name"
      assert user.email == "some_updated@email.com"
      assert user.password == "Some Updated Password"
      assert user.password_confirmation == "Some Updated Password"
    end

    test "update_user/2 when params is invalid" do
      user = user_fixture()
      assert {:error, %Changeset{}} = Users.update_user(user, @invalid_params)
    end

    test "delete_user/1 when params is valid" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end
  end
end
