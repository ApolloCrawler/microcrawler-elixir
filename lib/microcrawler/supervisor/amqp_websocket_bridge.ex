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

        children = [
            amqp_websocket_bridge
        ]

        supervise(children, strategy: :one_for_one)
    end
end
