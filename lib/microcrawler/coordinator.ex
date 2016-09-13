defmodule Microcrawler.Coordinator do
    require Logger
    use GenServer

    def start_link(state, opts \\ []) do
        Logger.info("Starting #{__MODULE__}")

        GenServer.start_link(__MODULE__, state, opts)
    end
end
