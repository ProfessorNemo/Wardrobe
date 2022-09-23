# frozen_string_literal: true

RSpec.describe Wardrobe::TemperatureGetter do
  specify '#conversion' do
    converter_stub = class_double described_class

    params = {
      api_key: ENV.fetch('API_KEY', 'fake'),
      coordinates: [ENV.fetch('FAKE_LAT'), ENV.fetch('FAKE_LON')]
    }

    allow(converter_stub).to receive(:convert).with(params)
                                              .and_return((rand(-30..30).is_a?(Integer)))

    expect(converter_stub.convert(params)).to be(true)

    expect(converter_stub).to have_received(:convert).with(params).once
  end

  context 'when record request on cassette' do
    it 'can fetch & parse user data' do
      meteodata = VCR.use_cassette('data/forecast') do
        described_class.call(api_key: ENV.fetch('API_KEY'))
      end

      expect(meteodata).to be_kind_of(Hash)

      expect(meteodata.first).to be_kind_of(Array)

      expect(meteodata.first[1]).to respond_to(:keys)

      expect(meteodata).to have_key('coord')

      expect(meteodata).to have_key('main')

      expect(meteodata['cod']).to eq(200)

      expect(meteodata['main']['temp']).to be_kind_of(Float)

      puts meteodata.inspect
    end
  end
end
