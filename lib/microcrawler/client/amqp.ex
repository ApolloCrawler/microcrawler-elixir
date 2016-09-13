defmodule Microcrawler.Client.Amqp do
    require Logger

    @server __MODULE__

    def start_link() do
        Logger.info("Starting #{__MODULE__}")

#        amqp_uri = config["amqp"]["uri"]
#
#        # Connect to AMQP
#        {:ok, conn} = AMQP.Connection.open(amqp_uri)
#        {:ok, chan} = AMQP.Channel.open(conn)
#
#        handler = fn(payload, _meta) ->
#                IO.puts("Received: #{payload}")
#        end

        GenEvent.start_link [{:name, @server}]
    end

    # code omitted
end
