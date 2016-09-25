defmodule MicrocrawlerTest.Downloader do
    use ExUnit.Case

    @valid_url "https://google.com"
    @invalid_url "https://invalid.url"
    @xkcd_url "http://xkcd.com/"

    test "Get valid URL - #{@valid_url}" do
        Microcrawler.Downloader.get!(@valid_url)
    end

    test "Get invalid URL - #{@invalid_url}" do
        assert_raise HTTPoison.Error, fn ->
            Microcrawler.Downloader.get!(@invalid_url)
        end
    end

    test "Parse Title of #{@xkcd_url}" do
        {:ok, res} = Microcrawler.Downloader.get(@xkcd_url)
        assert(res.status_code == 200)

        [{"title", [], [title]}] = Floki.find(res.body, "head > title")
        assert(title)
    end
end
