defmodule Microcrawler.Supervisor.Collector do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link(_args \\ nil) do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        couchbase = worker(Microcrawler.Client.Couchbase, [])
        elasticsearch = worker(Microcrawler.Client.Elasticsearch, [])

        # Pass Couchbase's and Elasticsearch's PIDs to Collector
        collector = worker(Microcrawler.Worker.Collector, [[couchbase, elasticsearch], [name: Microcrawler.Worker.Collector]])

        # Pass Collector's PID to clients
        amqp = worker(Microcrawler.Client.Amqp, [collector])

        children = [
            collector,
            amqp,
            couchbase,
            elasticsearch
        ]

        supervise(children, strategy: :one_for_one)
    end
end
