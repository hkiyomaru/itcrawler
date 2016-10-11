require 'json'

module JsonHandler
  def load_json(filepath)
    json_file = File.open(filepath).read
    json = JSON.load(json_file)
  end

  def save_json(json, filepath)
    open(filepath, "w") do |io|
      JSON.dump(json, io)
    end
  end
end
