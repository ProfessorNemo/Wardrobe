# frozen_string_literal: true

require 'thing'

describe Thing do
  let(:thing) { Thing.new(name: 'Шлепанцы', type: 'Обувь', temp_range: 20..40) }

  let(:thing_from_file) { Thing.read_file('./spec/fixtures/2.txt') }

  describe '#read_file' do
    it "returns instance of #{Thing}" do
      expect(thing_from_file).to be_an_instance_of Thing
    end

    it 'read file correctly' do
      expect(thing.name).to eq 'Шлепанцы'
      expect(thing.type).to eq 'Обувь'
      expect(thing.temp_range).to eq 20..40
    end

    it 'read file correctly' do
      expect(thing_from_file.name).to eq 'Шлепанцы'
      expect(thing_from_file.type).to eq 'Обувь'
      expect(thing_from_file.temp_range).to eq 20..40
    end
  end

  describe '#new' do
    it 'defines instance variables' do
      expect(thing).to have_attributes(name: 'Шлепанцы', type: 'Обувь', temp_range: 20..40)
    end
  end

  describe '#to_s' do
    it 'returns string representation of object' do
      expect(thing.to_s).to eq("#{thing.name} (#{thing.type})")
    end
  end

  describe '#suitable?' do
    context 'when garment is suitable for given temperature' do
      it 'returns true' do
        expect(thing.suitable?(20)).to be true
      end
    end

    context 'when garment is not suitable for given temperature' do
      it 'returns false' do
        expect(thing.suitable?(-50)).to be false
      end
    end
  end
end
