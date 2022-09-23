#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'main'

if File.exist?('../spec/fixtures/vcr_cassettes/data/forecast.yml')
  forecast = Forecast.new 'forecast'

  puts forecast.to_s
end
