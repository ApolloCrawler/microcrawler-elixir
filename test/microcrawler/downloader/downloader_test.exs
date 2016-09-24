defmodule MicrocrawlerTest.Downloader do
    use ExUnit.Case

    @valid_url "https://google.com"
    @invalid_url "https://invalid.url"

    test "Get valid URL - #{@valid_url}" do
        HTTPoison.get!(@valid_url)
    end

    test "Get invalid URL - #{@invalid_url}" do
        assert_raise HTTPoison.Error, fn ->
            HTTPoison.get!(@invalid_url)
        end
    end
end
