defmodule Salve.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Argon2

  @required_params [:name, :email, :password, :password_confirmation]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, redact: true
    field :password_confirmation, :string, redact: true

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password, message: "does not match password")
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    hash_password = Argon2.hash_pwd_salt(password)
    change(changeset, %{password: hash_password, password_confirmation: hash_password})
  end

  defp put_password_hash(changeset), do: changeset
end
