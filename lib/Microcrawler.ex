# Inspired by http://pedroassumpcao.ghost.io/creating-a-supervision-tree-for-elixir-genevent-behavior/

defmodule Microcrawler do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            supervisor(Microcrawler.Supervisor.Event, [])
        ]

        opts = [strategy: :one_for_one, name: Microcrawler.Supervisor]
        Supervisor.start_link(children, opts)
    end
end


