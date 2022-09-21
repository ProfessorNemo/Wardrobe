# frozen_string_literal: true

RSpec.describe Wardrobe::Thing do
  # let(:thing) { described_class.new(name: 'Шлепанцы', type: 'Обувь', temp_range: 20..40) }

  let(:thing_class) { Struct.new(:name, :type, :temp_range) }
  let(:thing) { described_class.new(thing_class.new('Шлепанцы', 'Обувь', 20..40)) }
  let(:thing_from_file) { described_class.read_file('spec/fixtures/2.txt') }

  describe '#read_file' do
    it "returns instance of #{described_class}" do
      expect(thing_from_file).to be_an_instance_of described_class
    end

    it 'returns range' do
      expect(thing.temp_range).to eq 20..40
      expect(thing.temp_range).to be_an_instance_of(Range)
    end

    it 'returns name' do
      expect(thing.name).to eq 'Шлепанцы'
      expect(thing.name).to be_an_instance_of(String)
    end

    it 'returns type' do
      expect(thing.type).to eq 'Обувь'
      expect(thing.type).to be_an_instance_of(String)
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
        expect(thing.suitable?(25)).to be true
      end
    end

    context 'when garment is not suitable for given temperature' do
      it 'returns false' do
        expect(thing.suitable?(-50)).to be false
      end
    end
  end

  describe '#add_new_thing' do
    it 'How to mock File open for write' do
      content = { name: 'Берцы', type: 'Обувь', temp_range: '(-15, 2)' }

      buffer = StringIO.new

      filename = 'somefile.txt'

      File.stub(:open).and_yield(buffer)

      File.open(filename, 'w') do |f|
        f.puts content[:name]
        f.puts content[:type]
        f.puts content[:temp_range]
      end

      word = buffer.string.split(/\s+/).first(2)

      val = buffer.string.scan(/-?\d+-?/)

      data = { name: word[0], type: word[1], temp_range: "(#{val[0].to_i}, #{val[1].to_i})" }

      # чтение буфера и проверка его содержимого
      expect(data).to eq(content)
    end
  end
end
