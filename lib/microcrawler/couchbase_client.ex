defmodule Microcrawler.CouchbaseClient do
    require Logger

    @server __MODULE__

    def start_link do
        Logger.info('Starting Couchbase Client')

        GenEvent.start_link [{:name, @server}]
    end

    # code omitted
end
