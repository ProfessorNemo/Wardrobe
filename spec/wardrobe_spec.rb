# frozen_string_literal: true

require 'thing'
require 'wardrobe'

describe Wardrobe do
  let(:garments) do
    [
      Thing.new(name: 'Водолазка', type: 'Кофта', temp_range: 15..20),
      Thing.new(name: 'Зимняя куртка', type: 'Верхняя одежда', temp_range: -40..3),
      Thing.new(name: 'Кроссовки', type: 'Обувь', temp_range: 10..15)
    ]
  end

  let(:wardrobe) { Wardrobe.new(garments) }

  let(:wardrobe_from_dir) { Wardrobe.read_from_dir_files('./spec/fixtures/*.txt') }

  describe '#read_from_dir_files' do
    it 'returns a Wardrobe instance' do
      expect(wardrobe_from_dir).to be_an_instance_of Wardrobe
    end

    it 'reads all text files and returns the number of instances' do
      expect(wardrobe_from_dir.garments.size).to eq 5
    end

    it 'reads all text files and checks for compliance' do
      expect(wardrobe_from_dir.garments).to all be_an_instance_of Thing
    end
  end

  describe '#new' do
    it 'checks for compliancen' do
      expect(wardrobe.garments).to eq garments
    end
  end

  describe '#clothes_by_weather' do
    context 'when clothes by temperature exist' do
      it 'return clothes list depending temperature' do
        expect(wardrobe.clothes_by_weather(15).size).to eq 2
        expect(wardrobe.clothes_by_weather(15).map(&:type)).to match_array %w[Обувь Кофта]
      end
    end

    context 'when clothes by temperature do not exist' do
      it 'returns an empty clothing collection' do
        expect(wardrobe.clothes_by_weather(-50)).to be_empty
      end
    end
  end
end
