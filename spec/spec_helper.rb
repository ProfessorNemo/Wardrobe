# frozen_string_literal: true

require_relative '../lib/main'
require 'byebug'
require 'dotenv/load'
require 'webmock/rspec'

# Загрузка любых файлов из директории support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/specs.txt'

  # Разрешаем делать подключения к реальным сервисам
  WebMock.allow_net_connect!

  WebMock::API.prepend(Module.new do
    extend self
    # disable VCR when a WebMock stub is created
    # for clearer spec failure messaging
    def stub_request(*args)
      # Выключаем VCR в тех случаях, когда работает WebMock и наоборот
      VCR.turn_off!
      super
    end
  end)

  config.before { VCR.turn_on! }
end
