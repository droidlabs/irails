# Welcome to iRails

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

