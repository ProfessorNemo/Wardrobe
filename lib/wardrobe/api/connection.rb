# frozen_string_literal: true

module Wardrobe
  module Api
    module Connection
      OPENWEATHERMAP_API_URL = 'https://api.openweathermap.org/data/2.5/weather?'
      MY_IP_API_URL = 'https://api.myip.com/'

      def connection(client)
        response ||= Faraday.get(OPENWEATHERMAP_API_URL, options(client))

        JSON.parse(response.body)
      end

      private

      def options(client)
        {
          lat: ENV.fetch('FAKE_LAT'),
          lon: ENV.fetch('FAKE_LON'),
          appid: client.token,
          units: 'metric'
        }
      end
    end
  end
end
