# frozen_string_literal: true

module Wardrobe
  class TemperatureGetter
    extend Wardrobe::Api::Converter

    class << self
      def call(api_key:)
        new(api_key).call
      end

      def conversion(api_key, coordinates)
        convert api_key: api_key, coordinates: coordinates
      end
    end

    def call
      retries = 1
      max_retries = 3
      begin
        response ||= Faraday.get(OPENWEATHERMAP_API_URL, options)
      rescue Faraday::Error => e
        puts "Произошла ошибка класса #{e.class.name}:\n#{e.message}}"
        puts 'Не удалось открыть TCP-соединение с сервером:('

        raise 'Запросили 3 раза, но увы:(' unless retries < max_retries

        retries += 1
        sleep 2**retries
        retry # выполнить блок begin еще раз
      rescue StandardError => e
        puts e.class.name
        abort e.message
      else
        JSON.parse(response.body)
      end
    end

    private

    attr_reader :api_key

    OPENWEATHERMAP_API_URL = 'https://api.openweathermap.org/data/2.5/weather?'
    MY_IP_API_URL = 'https://api.myip.com/'

    def initialize(api_key)
      @api_key = api_key
    end

    def ip_address
      @ip_address ||= JSON.parse(Faraday.get(MY_IP_API_URL).body)['ip']
    end

    def coordinates
      @coordinates ||= Geocoder.search(ip_address).first.coordinates
    end

    def latitude
      coordinates.first
    end

    def longitude
      coordinates.last
    end

    def options
      {
        lat: latitude,
        lon: longitude,
        appid: api_key,
        units: 'metric'
      }
    end
  end
end
