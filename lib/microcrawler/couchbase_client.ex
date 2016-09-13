defmodule Microcrawler.CouchbaseClient do
  @server __MODULE__

  def start_link do
    IO.puts 'Starting Couchbase Client'

    GenEvent.start_link [{:name, @server}]
  end

  # code omitted
end
