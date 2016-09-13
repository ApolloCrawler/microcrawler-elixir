defmodule Microcrawler.AmqpClient do
    require Logger

    @server __MODULE__

    def start_link do
        Logger.info('Starting AMQP Client')

        GenEvent.start_link [{:name, @server}]
    end

    # code omitted
end
