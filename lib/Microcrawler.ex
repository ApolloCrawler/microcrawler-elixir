defmodule Microcrawler do
  use Application

  def start(_type, _args) do
    # res = Execjs.eval "'red yellow blue'.split(' ')"
    # Apex.ap res

    # Read config file
    config_path = Path.join([System.user_home(), '.microcrawler', 'config.json'])
    res = case File.read(config_path) do
      {:ok, body}      -> run(parse_config(body))
      {:error, reason} -> Apex.ap reason
    end
    res
  end

  def parse_config(data) do
    Poison.Parser.parse!(data)
  end

  def run(config) do
    amqp_uri = config["amqp"]["uri"]

    # Connect to AMQP
    {:ok, conn} = AMQP.Connection.open(amqp_uri)
    {:ok, chan} = AMQP.Channel.open(conn)

    handler = fn(payload, _meta) ->
        IO.puts("Received: #{payload}")
    end

    IO.puts "Starting AMQP"
    Task.start(fn -> AMQP.Queue.subscribe(chan, "collector", handler) end)

    receive do
    _ -> :ok
    end
  end
end
