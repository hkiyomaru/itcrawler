require './json_handler'
require './twitter_client'
require './tweet_crawler'
require './image_saver'


class ITCrawler
  include JsonHandler
  include TwitterClient
  include TweetCrawler
  include ImageSaver

  def initialize(query, count, lang, since_id)
    @query = query
    @count = count
    @lang = lang
    @since_id = since_id
    @image_meta_data = []
    @index = 0
  end

  def set_query(query)
    @query = query
  end

  def set_count(count)
    @count = count
  end

  def set_lang(lang)
    @lang = lang
  end

  def set_since_id(since_id)
    @since_id = since_id
  end

  def get_query()
    return @query
  end

  def get_count()
    return @count
  end

  def get_lang()
    return @lang
  end

  def get_since_id()
    return @since_id
  end

  def get_image_meta_data()
    return @image_meta_data
  end

  def get_index()
    return @index
  end

  def extract_it(tweets)
    tweets.take(@count).each do |tw|
      if tw.media? then
        tw.media.each do |m|
          if m.is_a?(Twitter::Media::Photo)
            puts ("text: #{tw.full_text}")
            puts ("media: #{m.media_url}")
            image_information = {id: @index,
                                 description: tw.full_text,
                                 positive: 1,
                                 negative: 0
                                }
            save_image(m.media_url, @index)
            @index += 1
            @image_meta_data << image_information
          end
        end
      end
    end
  end
end
