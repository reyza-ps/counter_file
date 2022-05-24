class CounterFile
  def initialize(path)
    @directory = Dir[File.join(path, '**', '*')]
    @data      = {}
  end

  attr_accessor :data, :directory

  def execute
    grouping_and_hashing_data
    determine_file
  end

  def grouping_and_hashing_data
    directory.each_with_index do |file, index|
      f            = File.open(file)
      content_file = f.read
      if data.has_key?(content_file.strip.to_sym)
        data[content_file.strip.to_sym].push(file)
      else
        data.merge!("#{content_file.strip}": [file])
      end
    end
  end

  def determine_file
    result = ""
    temp   = []
    data.each_with_index do |(key, value), index|
      if temp.empty? || value.size > temp[index - 1]
        result = key.to_s.concat(" #{value.size}")
      end
      temp.push(value.size)
    end
    puts result
  end
end

CounterFile.new("./RUBYTEST").execute