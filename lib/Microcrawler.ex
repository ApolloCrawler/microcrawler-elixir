# Inspired by http://pedroassumpcao.ghost.io/creating-a-supervision-tree-for-elixir-genevent-behavior/

defmodule Microcrawler do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            supervisor(Microcrawler.EventSupervisor, [])
        ]

        opts = [strategy: :one_for_one, name: Microcrawler.Supervisor]
        Supervisor.start_link(children, opts)
    end
end

defmodule Microcrawler.EventSupervisor do
    use Supervisor

    @server __MODULE__

    def start_link do
        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        children = [
            worker(Microcrawler.Client.Amqp, []),
            worker(Microcrawler.Client.Couchbase, []),
            worker(Microcrawler.Client.Elasticsearch, [])
        ]

#        config_path = Path.join([System.user_home(), '.microcrawler', 'config.json'])
#        res = case File.read(config_path) do
#            {:ok, body}      -> run(parse_config(body))
#            {:error, reason} -> Apex.ap reason
#        end
#
#        Poison.Parser.parse!(data)
#
#        amqp_uri = config["amqp"]["uri"]
#
#        # Connect to AMQP
#        {:ok, conn} = AMQP.Connection.open(amqp_uri)
#        {:ok, chan} = AMQP.Channel.open(conn)
#
#        handler = fn(payload, _meta) ->
#                IO.puts("Received: #{payload}")
#        end

        supervise(children, strategy: :one_for_one)
    end
end

