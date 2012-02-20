# Welcome to iRails

Simple template for Rails 3.1 based projects

## Installation

* $ git clone git://github.com/creadroid/irails.git myapp
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

Licenced under [GNU GPL2](http://www.gnu.org/licenses/gpl-2.0.html).

## Thanks for using iRails!

Hope, you'll enjoy iRails!

Cheers, [Droid Labs](http://droidlabs.pro).

