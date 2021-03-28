defmodule Salve.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name,                  :string
      add :email,                 :string
      add :password,              :string
      add :password_confirmation, :string

      timestamps()
    end
  end
end
