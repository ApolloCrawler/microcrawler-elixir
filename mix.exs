defmodule Microcrawler.Mixfile do
  use Mix.Project

  def project do
    [
      app: :microcrawler,
      version: "0.0.1",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Microcrawler, []},
     applications: [:logger, :crypto]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:amqp_client, git: "https://github.com/jbrisbin/amqp_client.git", override: true},
      {:amqp, "~> 0.1.4"},
      {:apex, "~>0.5.2"},
      {:cberl, git: "https://github.com/chitika/cberl", override: true},
      {:dialyxir, "~> 0.3.5", only: [:dev]},
      {:execjs, "~> 1.1.3"},
      {:poison, "~> 1.5"},
      {:tirexs, "~> 0.8.8"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]
end
