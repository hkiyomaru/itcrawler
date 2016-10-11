require 'twitter'

module TweetCrawler
  def search(client)
    begin
      tweets = client.search(
        @query,
        count: @count,
        lang: @lang,
        result_type: "recent",
        exclude: "retweets",
        since_id: @since_id
      )
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end
end
