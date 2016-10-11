require 'open-uri'

module ImageSaver
  def save_image(url, index)
    dirName = "data/images/"
    filePath = dirName << index.to_s << ".jpg"

    open(filePath, 'wb') do |output|
      begin
        open(url) do |data|
          output.write(data.read)
        end
      rescue Exception=> each
        return -1 # failure
      end
    end
    return 0 # success
  end
end
