defmodule HelloApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloApiWeb.Telemetry,
      HelloApi.Repo,
      {DNSCluster, query: Application.get_env(:hello_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloApi.PubSub},
      # Start a worker by calling: HelloApi.Worker.start_link(arg)
      # {HelloApi.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
