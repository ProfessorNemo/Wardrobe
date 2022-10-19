# Консольное приложение `wardrobe`
###### Язык написания - Ruby

## Описание приложения:
Согласно текущей температуре воздуха на улице, приложение генерирует подходящий набор одежды. Используется информационный метеоресурс [`openweathermap`](https://home.openweathermap.org) с автоматическим определением температуры воздуха
на улице по географическим координатам и ip-адресу. Перед запуском программы Вам необходимо активировать API-ключ по ссылке [`sign_in`](https://home.openweathermap.org/users/sign_in), добавить гем "dotenv", в корне проекта создать файл ".env" и установить в него API-ключ.
## Установка и запуск:

**Примечание:** Это ruby-приложение, поэтому необходимо
чтобы на вашем компьютере был установлен интерпретатор Ruby.

1. Перенесите содержимое данного репозитория на свой компьютер
```
git remote add origin git@github.com:ProfessorNemo/wardrobe.git
```
2. Чтобы запустить приложение в этой же директории
следует воспользоваться следующей командой:
```
cd lib && ruby runner.rb
```
В папке `data` лежат текстовые файлы вот в таком формате:

> <Название шмотки>\
> <Тип шмотки>\
> <Диапазон температур>

Например,

> Шапка-ушанка\
> Головной убор\
> (-20, -5)

или

> Шлепанцы\
> Обувь\
> (+20, +40)

Программа поддерживает добавление в папку `data` новых предметов и типов одежды, например: шарфы, футболки, перчатки.
Заранее набор типов вещей не известен.

## Пример работы программы:
```
cd lib && ruby runner.rb

Текущая температура: 5.05 C
Предлагаю надеть:
Кожаная куртка (Верхняя одежда (верх))

Не нашли подходящих вещей в гардеробе?
Хотите добавить новую вещь? (Y/N)
n
Всего хорошего


Не нашли подходящих вещей в гардеробе?
Хотите добавить новую вещь? (Y/N)
y
Введите наименование
Арктический комбинезон
Введите категорию
Верхняя и нижняя одежда
Введите диапазон температуры в формате: '(мин, макс)'
(-70, -30)

вещь добавлена!
Запустите программу снова для подбора одежды
```
___

Программа покрыта тестами. Необходима установка RSpec, WebMock и VCR. Запуск всех тестов осуществляется командой:

```
$ bundle exec rspec
```
Чтобы записать ответ от сервера на кассету по адресу "spec/fixtures/vcr_cassettes/data/forecast.yml", необходимо
запустить слудующий тест:

```
$ bundle exec rspec spec/lib/wardrobe/temperature_getter_spec.rb
```
Запрос к api будет выполнен только один раз (см. [`vcr`](https://github.com/vcr/vcr)) даже при последующей реализации теста и записан
в файл "forecast.yml". Для обновления данных файл "forecast.yml" следует просто удалить.
В директории "api_cassettes" реализованы подходы на базе метапрограммирования для работы с данными ответа от сервера. Для последующего
обращения к файлу "forecast.yml" следует выполнить команду:

```
$ cd api_cassettes && ruby demo.rb
```
Результат будет выглядеть следующем образом:

```
Дата запроса: Fri, 23 Sep 2022 14:25:24 GMT


Адрес: Palace Square, Palace District, Saint Petersburg, Northwestern Federal District, 190107, Russia


Температура: 12.05 (ощущается как 10.93)


Атм.давл.: 1018


Влажность: 62


Ветер (скор./напр.): 3 (50)
```
___
