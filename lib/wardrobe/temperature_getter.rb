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
      response ||= Faraday.get(OPENWEATHERMAP_API_URL, options)

      JSON.parse(response.body)
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
