$ bundle exec rspec
$ bundle exec rspec spec/lib/wardrobe/thing_spec.rb
$ bundle exec rspec spec/lib/wardrobe/checkroom_spec.rb
$ bundle exec rspec spec/lib/wardrobe/gen_range_spec.rb
$ bundle exec rspec spec/lib/wardrobe/temperature_getter_spec.rb

$ bundle exec rspec spec/requests/converter_spec.rb
$ bundle exec rspec spec/lib/wardrobe/api/client_spec.rb

<!-- Запустить 3 самых быстрых теста -->
$ rspec . --profile 3

% запустить только те тесты, заголовки которых (названия) содержат слово
% "return" например:
$ rspec -e returns

<!-- Запустить только те тесты, которые содержат тэг "fit, fspecify, fexample, fcontext или fdescribe" -->
$ rspec --tag focus



(byebug) response
"{\"coord\":{\"lon\":30.3141,\"lat\":59.9386},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"base\":\"stations\",\"main\":{\"temp\":10.05,\"feels_like\":9.1,\"temp_min\":10.05,\"temp_max\":10.05,\"pressure\":1023,\"humidity\":76},\"visibility\":10000,\"wind\":{\"speed\":1,\"deg\":0},\"clouds\":{\"all\":0},\"dt\":1663793148,\"sys\":{\"type\":1,\"id\":8926,\"country\":\"RU\",\"sunrise\":1663731604,\"sunset\":1663776231},\"timezone\":10800,\"id\":519690,\"name\":\"Novaya Gollandiya\",\"cod\":200}"
(byebug) JSON.parse(response)['main']['temp'].to_f
10.05
(byebug) JSON.parse(response)['main']
{"temp"=>10.05, "feels_like"=>9.1, "temp_min"=>10.05, "temp_max"=>10.05, "pressure"=>1023, "humidity"=>76}
(byebug)


Faraday.get(OPENWEATHERMAP_API_URL, options).headers
{"server"=>"openresty", "date"=>"Wed, 21 Sep 2022 20:51:24 GMT", "content-type"=>"application/json; charset=utf-8", "content-length"=>"467", "connection"=>"keep-alive", "x-cache-key"=>"/data/2.5/weather?lat=59.94&lon=30.31&units=metric", "access-control-allow-origin"=>"*", "access-control-allow-credentials"=>"true", "access-control-allow-methods"=>"GET, POST"}

(byebug) Faraday.get(OPENWEATHERMAP_API_URL, options).headers.class
Faraday::Utils::Headers


Заголовки ответа:

HTTP/1.1 200 OK
Server: openresty
Date: Wed, 21 Sep 2022 20:40:59 GMT
Content-Type: application/json; charset=utf-8
Content-Length: 470
Connection: keep-alive
X-Cache-Key: /data/2.5/weather?lat=59.94&lon=30.31
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Access-Control-Allow-Methods: GET, POST

Заголовки запроса:

GET /data/2.5/weather?lat=59.9386&lon=30.3141&appid=add44ecb53335285caa7876b0970ee2d HTTP/1.1
Host: api.openweathermap.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101 Firefox/104.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Cookie: _ga=GA1.2.939571078.1662597876; signed_in=ProfessorNemo
Upgrade-Insecure-Requests: 1
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
Sec-Fetch-User: ?1

Ответ от сервера:

(byebug) JSON.parse(response)
{"coord"=>{"lon"=>30.3141, "lat"=>59.9386}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}], "base"=>"stations", "main"=>{"temp"=>10.05, "feels_like"=>9.1, "temp_min"=>10.05, "temp_max"=>10.05, "pressure"=>1023, "humidity"=>76}, "visibility"=>10000, "wind"=>{"speed"=>1, "deg"=>0}, "clouds"=>{"all"=>0}, "dt"=>1663793148, "sys"=>{"type"=>1, "id"=>8926, "country"=>"RU", "sunrise"=>1663731604, "sunset"=>1663776231}, "timezone"=>10800, "id"=>519690, "name"=>"Novaya Gollandiya", "cod"=>200}
