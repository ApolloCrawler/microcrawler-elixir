defmodule Microcrawler.Supervisor.Collector do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link(_args \\ nil) do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        collector = worker(Microcrawler.Worker.Collector, [[], [name: Microcrawler.Worker.Collector]])

        # Pass Collector's PID to clients
        amqp = worker(Microcrawler.Client.Amqp, [collector])
        couchbase = worker(Microcrawler.Client.Couchbase, [collector])
        elasticsearch = worker(Microcrawler.Client.Elasticsearch, [collector])

        children = [
            collector,
            amqp,
            couchbase,
            elasticsearch
        ]

        supervise(children, strategy: :one_for_one)
    end
end
