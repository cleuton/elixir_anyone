defmodule HelloApi.Repo do
  use Ecto.Repo,
    otp_app: :hello_api,
    adapter: Ecto.Adapters.Postgres
end
