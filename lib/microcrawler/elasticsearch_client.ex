defmodule Microcrawler.ElasticsearchClient do
  @server __MODULE__

  def start_link do
    IO.puts 'Starting Elasticsearch Client'

    GenEvent.start_link [{:name, @server}]
  end

  # code omitted
end
