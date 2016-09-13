defmodule Microcrawler.Client.Couchbase do
    require Logger

    @server __MODULE__

    def start_link() do
        Logger.info('Starting Couchbase Client')

        GenEvent.start_link [{:name, @server}]
    end

    def init do
        Logger.info('This is init')
    end

    # code omitted
end
