defmodule Salve.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Salve.Repo
  alias Salve.User

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

  def create(%{} = params) do
    changeset(%User{}, params)
    |> Repo.insert()
  end

  def update(%{} = params) do
    Repo.get!(User, params.id)
    |> change(params)
    |> Repo.update()
  end

  def delete(%{} = params) do
    Repo.get!(User, params.id)
    |> Repo.delete()
  end
end
