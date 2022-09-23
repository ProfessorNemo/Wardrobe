# frozen_string_literal: true

class Base
  KEYS = %w[coord main wind].freeze

  def initialize(resource)
    load_data_from resource
  end

  def load_data_from(resource)
    data = YAML.safe_load_file("../spec/fixtures/vcr_cassettes/data/#{resource}.yml", symbolize_names: true)

    # выборга данных о прогнозе
    selection = nested_hash_value(nested_hash_value(nested_hash_value(data, :http_interactions)[2], :response),
                                  :body)

    # результирующий хэш с прогнозом
    hash = KEYS.map do |key|
      nested_hash_value(JSON.parse(selection[:string]), key)
    end.inject(&:merge)

    hash
      .merge({ 'address' => location(hash), 'date' => nested_hash_value(data, :Date).join })
      .each do |method, value|
      instance_variable_set(:"@#{method}", value) if methods.include?(method.to_sym)
    end
  end

  # определение местоположения по координатам
  def location(hash)
    @location ||= Geocoder.search([hash['lat'], hash['lon']]).first.address
  end

  # поиск вложенного хэш-значения
  def nested_hash_value(obj, key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil

      obj.find { |*a| r = nested_hash_value(a.last, key) }
      r
    end
  end

  class << self
    def inherited(subclass)
      attrs = attributes_for subclass
      subclass.class_exec do
        attr_reader(*attrs)
      end
      super
    end

    private

    def attributes_for(klass)
      # @methods = JSON.parse File.read('./methods.json')
      # или
      @methods ||= YAML.safe_load_file('./methods.yml', symbolize_names: false)[0]

      @methods[klass.to_s.downcase]
    end
  end
end
