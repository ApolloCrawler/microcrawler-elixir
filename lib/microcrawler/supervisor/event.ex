defmodule Microcrawler.Supervisor.Event do
    use Supervisor

    @server __MODULE__

    def start_link do
        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        config_path = Path.join([System.user_home(), '.microcrawler', 'config.json'])
        config = case File.read(config_path) do
            {:ok, body}      -> Poison.Parser.parse!(body)
            {:error, reason} -> Apex.ap reason
        end

        coordinator = worker(Microcrawler.Worker.Coordinator, [[], [config: config, name: Coordinator]])
        collector = worker(Microcrawler.Worker.Collector, [[], [config: config, name: Collector]])
        amqp_websocket_bridge = worker(Microcrawler.Worker.AmqpWebsocketBridge, [[], [config: config, name: AmqpWebsocketBridge]])

        children = [
            coordinator,
            collector,
            amqp_websocket_bridge
        ]

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
