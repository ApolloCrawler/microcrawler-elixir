defmodule Microcrawler.Collector do
    require Logger
    use GenServer

    def start_link(state, opts \\ []) do
        Logger.info('Starting Collector')

        GenServer.start_link(__MODULE__, state, opts)
    end
end
