defmodule EMV.Mixfile do
  use Mix.Project
  def deps, do: [ {:ex_doc, ">= 0.0.0", only: :dev}]
  def application, do: [mod: {:emv, []}, applicatoins: [:inets]]
  def project do
    [ app: :emv,
      version: "0.7.0",
      description: "EMV Credit Card Generation",
      package: package(),
      deps: deps()]
  end
  def package do
    [ files: ~w(doc priv src mix.exs rebar.config LICENSE),
      licenses: ["ISC"],
      links: %{"GitHub" => "https://github.com/enterprizing/emv"}]
  end
end
