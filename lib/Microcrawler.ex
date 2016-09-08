defmodule Microcrawler do
  use Application

  def start(_type, _args) do
    IO.puts "starting"
    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
end
