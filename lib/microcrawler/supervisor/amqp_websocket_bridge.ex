defmodule Microcrawler.Supervisor.AmqpWebsocketBridge do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link(_args \\ nil) do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        amqp_websocket_bridge = worker(Microcrawler.Worker.AmqpWebsocketBridge, [[], [name: Microcrawler.Worker.AmqpWebsocketBridge]])

        # Pass AmqpWebsocketBridge's PID to clients
        amqp = worker(Microcrawler.Client.Amqp, [amqp_websocket_bridge])
        couchbase = worker(Microcrawler.Client.Couchbase, [amqp_websocket_bridge])

        children = [
            amqp_websocket_bridge,
            amqp,
            couchbase
        ]

        supervise(children, strategy: :one_for_one)
    end
end
