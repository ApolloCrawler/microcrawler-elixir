defmodule Microcrawler do
  use Application

  def start(_type, _args) do
    res = Execjs.eval "'red yellow blue'.split(' ')"
    Apex.ap res

    # {:ok, conn} = Connection.open("amqp://guest:guest@korczis.com")
    # {:ok, chan} = Channel.open(conn)

    # IO.puts
    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
end
