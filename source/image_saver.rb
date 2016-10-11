require 'open-uri'

module ImageSaver
  def save_image(url, index)
    dirName = "data/images/"
    filePath = dirName << index.to_s << ".jpg"

    open(filePath, 'wb') do |output|
      open(url) do |data|
        output.write(data.read)
      end
    end
  end
end
