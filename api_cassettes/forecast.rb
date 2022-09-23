# frozen_string_literal: true

class Forecast < Base
  def to_s
    puts <<~METEO
      \nДата запроса: #{date}\n
      \nАдрес: #{address}\n
      \nТемпература: #{temp} (ощущается как #{feels_like})\n
      \nАтм.давл.: #{pressure}\n
      \nВлажность: #{humidity}\n
      \nВетер (скор./напр.): #{speed} (#{deg})\n
    METEO
  end
end
