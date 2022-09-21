# frozen_string_literal: true

RSpec.describe Wardrobe::Checkroom do
  let(:garments) do
    [
      Wardrobe::Thing.new(name: 'Водолазка', type: 'Кофта', temp_range: 15..20),
      Wardrobe::Thing.new(name: 'Зимняя куртка', type: 'Верхняя одежда', temp_range: -40..3),
      Wardrobe::Thing.new(name: 'Кроссовки', type: 'Обувь', temp_range: 10..15)
    ]
  end

  let(:checkroom) { described_class.new(garments) }

  let(:checkroom_from_dir) { described_class.read_from_dir_files('spec/fixtures/*.txt') }

  describe '#read_from_dir_files' do
    it 'returns a checkroom instance' do
      expect(checkroom_from_dir).to be_an_instance_of described_class
    end

    it 'reads all text files and returns the number of instances' do
      expect(checkroom_from_dir.garments.size).to eq 5
    end

    it 'reads all text files and checks for compliance with the Thing class' do
      expect(checkroom_from_dir.garments).to all be_an_instance_of(Wardrobe::Thing)
    end
  end

  describe '#new' do
    it 'checks for compliancen' do
      expect(checkroom.garments).to eq garments
    end
  end

  describe '#clothes_by_weather' do
    context 'when clothes by temperature exist' do
      it 'return clothes list depending temperature' do
        expect(checkroom.clothes_by_weather(15).size).to be > 1
        expect(checkroom.clothes_by_weather(15).map(&:type)).not_to be_empty
      end

      it 'returns range' do
        expect(checkroom.clothes_by_weather(15).map(&:temp_range)).to include(a_kind_of(Range))
      end

      it 'returns name' do
        expect(checkroom.clothes_by_weather(15).map(&:name)).to include(a_kind_of(String))
      end

      it 'returns type' do
        expect(checkroom.clothes_by_weather(15).map(&:type)).to include(a_kind_of(String))
      end
    end

    context 'when clothes by temperature do not exist' do
      it 'returns an empty clothing collection' do
        expect(checkroom.clothes_by_weather(-70)).to be_empty
      end
    end
  end
end
