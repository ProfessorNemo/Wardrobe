# frozen_string_literal: true

module Wardrobe
  module Api
    module Connection
      OPENWEATHERMAP_API_URL = 'https://api.openweathermap.org/data/2.5/weather?'
      MY_IP_API_URL = 'https://api.myip.com/'

      def connection(client)
        response ||= Faraday.get(OPENWEATHERMAP_API_URL, options(client)).body

        JSON.parse(response)
      end

      private

      def options(client)
        {
          lat: ENV.fetch('LAT'),
          lon: ENV.fetch('LON'),
          appid: client.token,
          units: 'metric'
        }
      end
    end
  end
end
