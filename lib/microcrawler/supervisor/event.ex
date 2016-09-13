defmodule Microcrawler.Supervisor.Event do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        config_path = Path.join([System.user_home(), '.microcrawler', 'config.json'])
        config = case File.read(config_path) do
            {:ok, body}      -> Poison.Parser.parse!(body)
            {:error, reason} -> Apex.ap reason
        end

        coordinator = supervisor(Microcrawler.Supervisor.Coordinator, [], [config: config])
        collector = supervisor(Microcrawler.Supervisor.Collector, [], [config: config])
        amqp_websocket_bridge = supervisor(Microcrawler.Supervisor.AmqpWebsocketBridge, [], [config: config])

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
