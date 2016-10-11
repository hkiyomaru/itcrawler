require 'twitter'
require 'json'
require 'open-uri'

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
count = 100
lang = "en"
since_id = nil
begin
  tweets = client.search(
    query,
    count: count,
    lang: lang,
    result_type: "recent",
    exclude: "retweets",
    since_id: since_id
  )
rescue Twitter::Error::TooManyRequests => Error
  sleep error.rate_limit.reset_in + 1
  retry
end

def save_image(url, index)
  # ready filepath
  fileName = File.basename(url)
  dirName = "data/images/"
  filePath = dirName << index.to_s << ".jpg"

  # write image adata
  open(filePath, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end
end

image_meta_data = []
index = 0

tweets.take(count).each do |tw|
  if tw.media? then
    tw.media.each do |m|
      if m.is_a?(Twitter::Media::Photo)
        puts ("text: #{tw.full_text}")
        puts ("media: #{m.media_url}")
        image_information = {id: index,
                             description: tw.full_text,
                             positive: 1,
                             negative: 0
                            }
        save_image(m.media_url, index)
        image_meta_data << image_information
        index += 1
      end
    end
  end
end

open("data/image_meta_data.json", "w") do |io|
  JSON.dump(image_meta_data, io)
end
