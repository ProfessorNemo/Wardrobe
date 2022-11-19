# frozen_string_literal: true

require_relative 'main'

api_key = Dotenv.load('../.env')['API_KEY']

begin
  current_temperature = Wardrobe::TemperatureGetter.call(api_key: api_key)['main']['temp'].to_f
rescue Faraday::Error => e
  puts "Произошла ошибка класса #{e.class.name}:\n#{e.message}}"
  puts 'Не удалось открыть TCP-соединение с сервером:('
  puts 'Введите температуру вручную:'
  current_temperature = $stdin.gets.chomp.to_i
rescue StandardError => e
  puts e.class.name
  abort e.message
end

puts "Текущая температура: #{current_temperature} C"

clothes_collection = Wardrobe::Checkroom.read_from_dir_files('../data/*.txt')

clothes_list = clothes_collection.clothes_by_weather(current_temperature)

if clothes_list.empty?
  puts 'У вас нет подходящей одежды. Оставайтесь дома'
else
  puts 'Предлагаю надеть:', clothes_list
end

puts
puts 'Не нашли подходящих вещей в гардеробе?'
puts 'Хотите добавить новую вещь? (Y/N)'

answer = $stdin.gets.chomp.capitalize

yn = %w[Y N]

until yn.include?(answer)
  puts 'Y - да, N - нет'

  answer = $stdin.gets.chomp.capitalize
end

case answer
when 'N'
  puts 'Всего хорошего'
when 'Y'
  puts 'Введите наименование'
  name = $stdin.gets.chomp.capitalize

  puts 'Введите категорию'
  type = $stdin.gets.chomp.capitalize

  puts 'Введите минимально допустимую температуру'
  min_temp = $stdin.gets.chomp

  puts 'Введите максимально допустимую температуру'
  max_temp = $stdin.gets.chomp

  add_params = { name: name, type: type, temp_range: "(#{min_temp}, #{max_temp})" }

  # создаем новую вещь
  new_thing = Wardrobe::Thing.new(add_params)

  # записать файл с вещью
  new_thing.add_new_thing

  puts
  puts 'вещь добавлена!'
  puts 'Запустите программу снова для подбора одежды'
end
