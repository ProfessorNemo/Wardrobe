# frozen_string_literal: true

RSpec.describe Wardrobe::Api::Client do
  let(:test_client) { described_class.new(ENV.fetch('FAKE_KEY', 'fake')) }

  let(:const) do
    [
      'https://api.openweathermap.org/data/2.5/weather?',
      ENV.fetch('FAKE_KEY', 'fake'),
      ENV.fetch('LAT', 'fake'),
      ENV.fetch('LON', 'fake')
    ]
  end

  let(:link) { "#{const[0]}appid=#{const[1]}&lat=#{const[2]}&lon=#{const[3]}&units=metric" }

  specify '#connection' do
    # # настоящий заголовок ответа
    # # JSON.dump - получаем строку на основе хэша
    body = JSON.dump(
      'Server' => 'openresty',
      'Date' => 'Wed, 21 Sep 2022 20:40:59 GMT',
      'Content-Type' => 'application/json; charset=utf-8',
      'Content-Length' => '470',
      'Connection' => 'keep-alive',
      'X-Cache-Key' => "/data/2.5/weather?lat=#{const[2]}&lon=#{const[3]}",
      'Access-Control-Allow-Methods' => 'GET, POST'
    )

    # # заглушка для запроса (фейковый запрос и ответ)
    # # эти заголовки пытаются отправиться в реальном запросне
    stub = stub_request(:get, link)
           .with(
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'User-Agent' => 'Faraday v2.5.2'
             }
           )
           .to_return(status: 200, body: body, headers: {})

    meteodata = test_client.connection test_client

    # запрос был отправлен 1 раз
    expect(WebMock).to have_requested(:get, link).once

    expect(meteodata['X-Cache-Key']).to eq("/data/2.5/weather?lat=#{const[2]}&lon=#{const[3]}")

    expect(meteodata['Server']).to eq('openresty')

    # После этой строки счетчик запросов будет идти заново
    # WebMock.reset_executed_requests!

    # действительно ли такой запрос был? (не важн осколько раз)
    expect(stub).to have_been_requested

    puts meteodata.inspect
    puts test_client.inspect
  end

  it 'raises an error with invalid params' do
    stub_request(:get, link)
      .to_raise(StandardError)

    expect { test_client.connection({}) }.to raise_error(StandardError)
  end
end