# Inspired by http://pedroassumpcao.ghost.io/creating-a-supervision-tree-for-elixir-genevent-behavior/

defmodule Microcrawler do
    require Logger
    use Application

    def start(_type, _args) do
        Logger.info("Starting #{__MODULE__}")

        import Supervisor.Spec, warn: false

        children = [
            supervisor(Microcrawler.Supervisor.Event, [])
        ]

        opts = [strategy: :one_for_one, name: __MODULE__]
        Supervisor.start_link(children, opts)
    end
end


