defmodule Microcrawler.Supervisor.Coordinator do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link(_args \\ nil) do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        couchbase = worker(Microcrawler.Client.Couchbase, [])

        # Pass Couchbase's PID to Coordinator
        coordinator = worker(Microcrawler.Worker.Coordinator, [[couchbase], [name: Microcrawler.Worker.Coordinator]])

        # Pass Coordinator's PID to clients
        amqp = worker(Microcrawler.Client.Amqp, [coordinator])

        children = [
            coordinator,
            amqp,
            couchbase
        ]

        supervise(children, strategy: :one_for_one)
    end
end
