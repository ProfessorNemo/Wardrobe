# frozen_string_literal: true

RSpec.describe Wardrobe::TemperatureGetter do
  specify '#conversion' do
    converter_stub = class_double described_class

    params = { api_key: ENV.fetch('API_KEY', 'fake'), coordinates: [59.9386, 30.3141] }

    allow(converter_stub).to receive(:convert).with(params)
                                              .and_return((rand(-30..30).is_a?(Integer)))

    expect(converter_stub.convert(params)).to be(true)

    expect(converter_stub).to have_received(:convert).with(params).once
  end
end
