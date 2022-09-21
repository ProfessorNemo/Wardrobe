# frozen_string_literal: true

module Wardrobe
  module GenRange
    def parse_range(range_string)
      raise(Wardrobe::MissingValue, 'Range must be present!') if range_string.empty?

      range_string = range_string.is_a?(String) ? range_string : range_string.to_s

      arg = range_string.scan(/-?\d+-?/).map(&:to_i)

      raise(Wardrobe::RangeValueError, 'The first range value must be less than the second') if arg[0] >= arg[1]

      Range.new(*arg)
    end
  end
end
