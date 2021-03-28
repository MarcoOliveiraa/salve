defmodule Salve.Users.User do
  use Ecto.Schema

  alias Salve.Users

  import Ecto.Changeset

  @required_params [:name, :email, :password, :password_confirmation]

  schema "users" do
    field :name
    field :email
    field :password
    field :password_confirmation

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    hash_password = Bcrypt.Base.hash_password(password, Bcrypt.gen_salt(12, true))
    change(changeset, %{password: hash_password, password_confirmation: hash_password})
  end

  defp put_password_hash(changeset), do: changeset
end
