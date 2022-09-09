# frozen_string_literal: true

class Thing
  attr_reader :name, :type, :temp_range

  extend GenRange
  def self.read_file(path)
    lines = File.readlines(path, chomp: true)
    new(name: lines[0], type: lines[1], temp_range: parse_range(lines[2]))
  end

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
    @temp_range = params[:temp_range]
  end

  # добавить новую одежду в гардероб
  def add_new_thing
    dir_path_thing = File.join(Dir.pwd, 'lib').sub('/lib', '')
    File.open("#{dir_path_thing}/data/added_thing_#{Time.now.strftime('%F_%H:%M:%S')}.txt", 'w:UTF-8') do |file|
      file.puts name.to_s
      file.puts type.to_s
      file.puts temp_range.to_s
    end
  end

  def to_s
    "#{name} (#{type})"
  end

  def suitable?(temperature)
    temp_range.include?(temperature)
  end
end
