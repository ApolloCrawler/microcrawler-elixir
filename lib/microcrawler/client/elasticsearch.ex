defmodule Microcrawler.Client.Elasticsearch do
    require Logger

    @server __MODULE__

    def start_link() do
        Logger.info("Starting #{__MODULE__}")

        GenEvent.start_link [{:name, @server}]
    end

    # code omitted
end
