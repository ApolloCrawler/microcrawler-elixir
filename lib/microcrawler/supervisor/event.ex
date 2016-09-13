defmodule Microcrawler.Supervisor.Event do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        # Construct config file path
        config_path = Path.join([System.user_home(), '.microcrawler', 'config.json'])

        # Inform user that we are trying to load config file (config.json)
        Logger.info("Loading config file '#{config_path}'")

        # Try to read config file
        res = case File.read(config_path) do
            # Return parsed file
            {:ok, body}      -> parse_config(body)

            # Return error
            {:error, reason} -> {:error, reason}
        end

        # Based on result decide if to run supervisor or return error
        case res do
            {:ok, _config} -> run(res)
            {:error, reason} -> error(reason)
        end
    end

    def parse_config(body) do
        {:ok, config: Poison.Parser.parse!(body)}
    end

    def run(_args) do
        coordinator = supervisor(Microcrawler.Supervisor.Coordinator, [nil], [])
        collector = supervisor(Microcrawler.Supervisor.Collector, [{nil}], [])
        amqp_websocket_bridge = supervisor(Microcrawler.Supervisor.AmqpWebsocketBridge, [nil], [])

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

    def error(reason) do
        Apex.ap(reason)

        # TODO: Properly fail-early somehow
        {:error, reason}
    end
end
