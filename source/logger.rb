module Logger
  def print_progress(text, media_url)
    puts ("index: #{@index}")
    puts ("  text: " << text[0..30] << "...")
    puts ("  media_url: " << media_url)
  end

  def print_success_or_failure(exit_code)
    if exit_code < 0
      puts ("    Failure. Next index=> #{@index}")
    else
      if @image_num[@polarity].is_a?(NilClass)
        @image_num[@polarity] = 1 # initialize
      else
        @image_num[@polarity] += 1 # otherwise, increment number of images
      end
      puts ("    Success. Next index=> #{@index}")
    end
  end

  def print_result
    puts ("######################################")
    puts ("* ALL IMAGE NUMBER: #{@index}")
    puts ("  - POSITIVE IMAGE NUMBER: #{@image_num["positive"]}")
    puts ("  - NEGATIVE IMAGE NUMBER: #{@image_num["negative"]}")
    puts ("######################################")
  end
end
