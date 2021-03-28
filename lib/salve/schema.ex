defmodule Salve.Schema do
  defmacro __using(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key :binary_id
    end
  end
end
