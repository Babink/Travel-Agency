defmodule Travel.Repo do
  use Ecto.Repo,
    otp_app: :travel,
    adapter: Ecto.Adapters.Postgres
end
