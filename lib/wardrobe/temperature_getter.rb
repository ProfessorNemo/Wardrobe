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
      connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request :url_encoded
        faraday.headers['user_agent'] = 'ruby application'
        faraday.headers['connection'] = 'keep-alive'
        faraday.headers['host'] = 'api.openweathermap.org'
      end

      response ||= connection.get(PATH, options)

      JSON.parse(response.body)
    end

    private

    attr_reader :api_key

    BASE_URL = 'https://api.openweathermap.org'
    PATH = '/data/2.5/weather?'
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
