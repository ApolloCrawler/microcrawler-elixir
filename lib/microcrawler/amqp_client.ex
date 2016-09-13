defmodule Microcrawler.AmqpClient do
  @server __MODULE__

  def start_link do
    IO.puts 'Starting AMQP Client'

    GenEvent.start_link [{:name, @server}]
  end

  # code omitted
end
