defmodule HelloApiWeb.PingController do
  use HelloApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok", message: "pong"})
  end
end