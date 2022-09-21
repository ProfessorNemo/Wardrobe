$ bundle exec rspec
$ bundle exec rspec spec/lib/wardrobe/thing_spec.rb
$ bundle exec rspec spec/lib/wardrobe/checkroom_spec.rb
$ bundle exec rspec spec/lib/wardrobe/gen_range_spec.rb
$ bundle exec rspec spec/lib/wardrobe/temperature_getter_spec.rb

$ bundle exec rspec spec/requests/converter_spec.rb


<!-- Запустить 3 самых быстрых теста -->
$ rspec . --profile 3

% запустить только те тесты, заголовки которых (названия) содержат слово
% "return" например:
$ rspec -e returns

<!-- Запустить только те тесты, которые содержат тэг "fit, fspecify, fexample, fcontext или fdescribe" -->
$ rspec --tag focus