# Тестовое задание для компании [Desire](https://desire-s.ru/)

#### Новость

Представляет собой объект новости и должен содержать следующую информацию:

* Заголовок
* Анонс
* Статус (опубликована/не опубликована)

#### Пользователь

Содержит в себе как минимум информацию о конкретном пользователе, а именно:

* Логин
* Пароль
* ФИО
* Подпись

Функции:

* Может создавать новость
* Может обновлять/удалять свою новость
* Может добавлять новость в избранное

#### Функции каталога

Взаимодействие с пользователем происходит посредством HTTP запросов к API серверу. Все ответы представляют собой JSON объекты. 
Сервер реализует следующие методы:

* Только аутентифицированный пользователь может создавать/обновлять
* Выдача всех новостей конкретного автора
* Выдача списка авторов
* Выдача списка новостей
* Показывать запрошенную
* Выдача всех непрочитанных пользователем новостей

#### Задание 

Формат маршрутов для доступа к методам, а также формат ответа и запросов мы предоставляем Вам реализовать и выбрать самим.
1. Спроектировать БД
2. Реализовать API согласно ТЗ
3. Реализовать аутентификацию в АПИ (регистрацию можно не делать)
4. Подготовить тестовые данные (дамп базы, скрипт для генерации тестового набора данных)
5. Покрыть код тестами
6. Выложить код в репозиторий на github

#### Используемые технологии

При выполнении задания требуется использовать следующие технологии:

* Ruby ~> 2.5
* Rails 5
* RSpec
* БД Postgres

# Запуск приложения

Для того, чтобы запустить приложение, выполните следующие команды у себя в окне терминала:

* Склонируйте репозиторий с GitHub и перейдите в папку приложения:
```
git clone https://github.com/cuurjol/desire_news_catalog.git
cd desire_news_catalog
```

* Установите необходимые гемы приложения, указанные в файле `Gemfile`:
```
bundle install
```

* Создайте базу данных, запустите миграции для базы данных и файл `seeds.rb` для создания записей в базу данных:
```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

Приложение использует СУБД `Postgresql`. При необходимости создайте нового пользователя в СУБД для этого приложения 
или измените СУБД на другую, изменив настройки файла `config/database.yml`.

* Запустите приложение:
```
bundle exec rails server
```

