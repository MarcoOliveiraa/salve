defmodule Salve.Users.User do
  use Ecto.Schema

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
  end
end
