require 'json'

class DataStore
  def initialize(file_name)
    @file_name = "./data/#{file_name}.json"
    write([]) unless File.file?(@file_name)
  end

  def write(data)
    write_data = JSON.generate(data)
    File.write(@file_name, write_data)
  end

  def read
    read_data = File.read(@file_name)
    JSON.parse(read_data)
  end
end
