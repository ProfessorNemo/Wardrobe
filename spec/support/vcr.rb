# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  # игнорировать запросы к сервесу codeclimate о состоянии кода
  # (или любой другой домен, для которогу не нужно записывать все запросы в кассету)
  c.ignore_hosts 'codeclimate.com'
  # передать один из адаптеров
  c.hook_into :webmock
  # декодироват ответ от сервера, если ответ был правильным образом сжат
  # с помощью одного из алгоритмов
  c.default_cassette_options = {
    decode_compressed_response: true
  }
  # путь, где будут лежать кассеты (файл .yml с запросом/ответом)
  c.cassette_library_dir = File.join(
    File.dirname(__FILE__), '..', 'fixtures', 'vcr_cassettes'
  )
  # чтоб реальный токен не попал в кассеты (замена на заглушку "<API_KEY>")
  c.filter_sensitive_data('<API_KEY>') do
    ENV.fetch('API_KEY', 'hidden')
  end
end
