defmodule Salve.UsersTest do
  use Salve.DataCase

  alias Salve.Users

  alias Ecto.Changeset

  describe "Users" do
    alias Salve.Users.User

    @valid_params   %{name: "Some Name", email: "some@email.com", password: "Some Password", password_confirmation: "Some Password"}
    @updated_params %{name: "Some Updated Name", email: "some_updated@email.com", password: "Some Updated Password", password_confirmation: "Some Updated Password"}
    @invalid_params %{name: "Some Name", email: "Some Email", password: "Some Password"}

    def user_fixture() do
      {:ok, user} = Users.create_user(@valid_params)
      user
    end

    test "create_user/1 when params is valid"do
      assert {:ok, %User{} = user} = Users.create_user(@valid_params)
        assert {:ok, user} == Argon2.check_pass(user, "Some Password", hash_key: :password)
      assert user.name == "Some Name"
      assert user.email == "some@email.com"
    end

    test "create_user/1 when params is invalid" do
      assert {:error, %Changeset{}} = Users.create_user(@invalid_params)
    end

    test "update_user/2 when params is valid" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @updated_params)
        assert {:ok, user} == Argon2.check_pass(user, "Some Updated Password", hash_key: :password)
      assert user.name == "Some Updated Name"
      assert user.email == "some_updated@email.com"
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

    test "get_user/1 when there is user" do
      user = user_fixture()
      assert user == Users.get_user!(user.id)
    end

    test "authenticate_user/1 when data access is valid" do
      user_fixture()
      assert {:ok, %User{}} = Users.authenticate_user(@valid_params.email, @valid_params.password)
    end

    test "authenticate_user/1 when data access is invalid" do
      user_fixture()
      assert {:error, :invalid_credentials} = Users.authenticate_user("email@test.com", "123456")
    end
  end
end
