require './crawler'

# search configuration
$query = ""
$polarity = ""
$count = 50
$lang = "en"
$since_id = nil

# file path
$twitter_api_config_path = 'config/twitter_api_config.json'
$queries = 'config/queries.json'
$image_meta_data_path = 'data/image_meta_data.json'

def main
  # initialize crawler
  crawler = ITCrawler.new($query, $polarity, $count, $lang, $since_id)

  config = crawler.load_json($twitter_api_config_path) # load settings
  queries = crawler.load_json($queries) # load queries
  client = crawler.create(config) # create twitter client

  queries.each do |key, array|
    crawler.set_polarity(key) # set positive or negative
    array.each do |query|
      crawler.set_query(query) # set query
      tweets = crawler.search(client) # search tweets
      crawler.extract_it(tweets) # extract images and corresponding text(tweets)
      crawler.save_json(crawler.get_image_meta_data, $image_meta_data_path) # save meta-data
    end
  end

  crawler.print_result() # print log

end


main()
