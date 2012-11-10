## Welcome to iRails

[![Build Status](https://secure.travis-ci.org/droidlabs/irails.png)](https://travis-ci.org/droidlabs/irails)
[![Dependency Status](https://gemnasium.com/droidlabs/irails.png)](https://gemnasium.com/droidlabs/irails)

Simple template for Rails 3.2 based projects

## Installation

* $ git clone git://github.com/droidlabs/irails.git myapp
* $ cd ./myapp
* $ cp config/database.yml.example config/database.yml
* Configure your config/database.yml
* $ bundle install
* $ rake db:setup

## Setup deploy to staging

* Configure config/deploy/staging.rb
* $ cap deploy:setup

## Setup javascript testing webdriver

* $ brew update && brew install phantomjs

## Data migrations

* Generate data migration
* $ rails g data_migration generate_user_tokens

* Run data migration
* $ rake data:migrate

## Admin panel

**PLEASE DON'T FORGET TO CHANGE ADMIN PASSWORD**

* url: yoursite.com/admin
* username: admin@example.com
* password: password

## License

Licenced under [MIT](http://www.opensource.org/licenses/mit-license.php).

## Thanks for using iRails!

Hope, you'll enjoy iRails!

Cheers, [Droid Labs](http://droidlabs.pro).

