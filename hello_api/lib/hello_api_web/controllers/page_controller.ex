defmodule HelloApiWeb.PageController do
  use HelloApiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
