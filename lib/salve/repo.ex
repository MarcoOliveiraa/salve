defmodule Salve.Repo do
  use Ecto.Repo,
    otp_app: :salve,
    adapter: Ecto.Adapters.Postgres
end
