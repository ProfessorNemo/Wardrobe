# frozen_string_literal: true

require 'byebug'
require 'json'
require 'dotenv/load'
require 'faraday'
require 'geocoder'
require_relative 'wardrobe/api/connection'
require_relative 'wardrobe/api/client'
require_relative 'wardrobe/errors'
require_relative 'wardrobe/api/converter'
require_relative 'wardrobe/gen_range'
require_relative 'wardrobe/checkroom'
require_relative 'wardrobe/temperature_getter'
