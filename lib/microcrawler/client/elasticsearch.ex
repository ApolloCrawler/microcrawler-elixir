defmodule Microcrawler.Client.Elasticsearch do
    require Logger

    @server __MODULE__

    def start_link(_args \\ nil) do
        Logger.info("Starting #{__MODULE__}")

        # GenEvent.start_link [{:name, @server}]
        GenEvent.start_link []
    end

    # code omitted
end
