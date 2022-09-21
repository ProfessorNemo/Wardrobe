# frozen_string_literal: true

RSpec.describe Wardrobe::GenRange do
  let(:dummy) { Class.new { include Wardrobe::GenRange }.new }

  describe '#parse_range' do
    it 'returns range' do
      expect(dummy.parse_range('(15, 30)')).to eq(15..30)
    end

    it 'returns class:Range' do
      expect(dummy.parse_range('(15, 30)')).to be_an_instance_of(Range)
    end
  end

  context 'when the data passed to the method is not valid' do
    it 'no data' do
      expect { dummy.parse_range('') }.to raise_error(Wardrobe::MissingValue, /Range must be present/)
    end

    it 'the first value of the range is not less than the second' do
      expect { dummy.parse_range('(30, 15)') }.to raise_error(Wardrobe::RangeValueError, /The first range value must/)
    end
  end
end
