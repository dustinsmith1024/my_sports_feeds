defmodule MSF.Mixfile do
  @moduledoc """
  my mixfile
  """
  use Mix.Project

  def project do
    [app: :my_sports_feeds,
     description: "A HTTP API wrapper for mysportsfeeds.com",
     source_url: "https://github.com/dustinsmith1024/my_sports_feeds",
     version: "2.0.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
      mod: {MSF, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:tesla, "~> 1.2.0"},
      {:hackney, "~> 1.14.0"}, # optional, but recommended adapter
      {:jason, ">= 1.0.0"} ,
    ]
  end

  defp package do
    [
      maintainers: ["Dustin Smith"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dustinsmith1024/my_sports_feeds"}
    ]
  end
end
