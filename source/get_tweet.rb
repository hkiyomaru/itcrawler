require './crawler'

# search configuration
$query = "happy"
$count = 50
$lang = "en"
$since_id = nil

# file path
$twitter_api_config_path = 'config/twitter_api_config.json'
$image_meta_data_path = 'config/data/image_meta_data.json'
$queries = 'config/queries.json'

def main
  # initialize crawler
  crawler = ITCrawler.new($query, $count, $lang, $since_id)

  # load settings
  config = crawler.load_json($twitter_api_config_path)
  # create twitter client
  client = crawler.create(config)
  # search tweets
  tweets = crawler.search(client)
  # extract images and corresponding text(tweets)
  crawler.extract_it(tweets)
  # save meta-data
  crawler.save_json(crawler.get_image_meta_data, $image_meta_data_path)
end


main()
