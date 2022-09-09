# frozen_string_literal: true

module GenRange
  private

  def parse_range(range_string)
    Range.new(*range_string.scan(/-?\d+-?/).map(&:to_i))
  end
end
