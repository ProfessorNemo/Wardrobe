# frozen_string_literal: true

require_relative 'thing'

module Wardrobe
  class Checkroom
    attr_reader :garments

    def self.read_from_dir_files(path)
      new(Dir[path].map { |file_name| Thing.read_file(file_name) })
    end

    def initialize(garments)
      @garments = garments
    end

    def clothes_by_weather(temperature)
      garments.select { |garment| garment.suitable?(temperature) }
              .shuffle
              .uniq(&:type)
    end
  end
end
