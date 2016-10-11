require 'twitter'
require 'json'

# load settings
setting_file = File.open("settings.json").read
settings = JSON.load(setting_file)

client = Twitter::REST::Client.new(
  consumer_key: settings["consumer_key"],
  consumer_secret: settings["consumer_secret"],
  access_token: settings["access_token"],
  access_token_secret: settings["access_token_secret"],
)

query = "happy"
since_id = nil
result_tweets = client.search(query, count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)

result_tweets.take(10).each_with_index do |tw, i|
  puts("#{i} : #{tw.user.screen_name} : #{tw.full_text}")
end
