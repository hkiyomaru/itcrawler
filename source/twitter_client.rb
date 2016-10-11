require 'twitter'

module TwitterClient
  def create(config)
    client = Twitter::REST::Client.new(
      consumer_key: config["consumer_key"],
      consumer_secret: config["consumer_secret"],
      access_token: config["access_token"],
      access_token_secret: config["access_token_secret"],
    )
  end
end
