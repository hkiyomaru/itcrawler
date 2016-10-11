require './json_handler'
require './twitter_client'
require './tweet_crawler'
require './image_saver'
require './logger'

class ITCrawler
  include JsonHandler
  include TwitterClient
  include TweetCrawler
  include ImageSaver
  include Logger

  def initialize(query, polarity, count, lang, since_id)
    set_query(query)
    set_polarity(polarity)
    set_count(count)
    set_lang(lang)
    set_since_id(since_id)
    @image_num = {
      "potisive"=> 0,
      "negative"=> 0
    }
    @image_meta_data = []
    @index = 0
  end

  def set_query(query)
    @query = query
  end

  def set_polarity(polarity)
    if polarity == "positive"
      @polarity = polarity
      @positive = 1
      @negative = 0
    elsif polarity == "negative"
      @polarity = polarity
      @positive = 0
      @negative = 1
    else
      @polarity = ""
      @positive = 0
      @negative = 0
    end
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

  def get_polarity()
    return @positive, @negative
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
            description = tw.full_text
            media_url = m.media_url
            print_progress(description, media_url) # print log
            image_information = {
              id: @index,
              description: description,
              positive: @positive,
              negative: @negative
            }
            if save_image(media_url, @index) < 0 then
              @index = @index # do nothing
              print_success_or_failure(-1) # print log
            else
              @index += 1
              @image_meta_data << image_information
              print_success_or_failure(1) # print log
            end
          end
        end
      end
    end
  end
end
