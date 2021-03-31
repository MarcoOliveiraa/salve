defmodule Salve.Users do
  alias Salve.Users.User
  alias Salve.Repo
  alias Argon2

  import Ecto.Query, only: [from: 2]

  def create_user(%{} = attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, %{} = attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user!(id), do: Repo.get!(User, id)

  def authenticate_user(email, password) do
    query = from u in User, where: u.email == ^email
    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}
      user ->
        if Argon2.verify_pass(password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
