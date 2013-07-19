# Pg::App::Name

It sets the application name for postgres database connections. It is available in PostgreSQL server 9.x.

[![Build Status](https://secure.travis-ci.org/vagmi/pg-app-name.png?branch=master)](http://travis-ci.org/vagmi/pg-app-name)

## Installation

Add this line to your application's Gemfile:

    gem 'pg-app-name'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pg-app-name

## Usage

It uses the environment variable `PG_APP_NAME` to set the application name. If you are using Rails, it automatically sets the rails app name as the application name for the database. Setting the environment variable will overwrite the Rails application name.

Start your app. Launch `psql` and query the `pg_stat_activity` table to watch the gem in action.

## Running the tests

You will need an installation of postgres to be able to run the tests. On OSX,
you can use [homebrew](http://mxcl.github.io/homebrew/) or
[Postgres.app](http://postgresapp.com/). You will also need a `postgres` role
and a database named `pg_app_name_test` in your postgres installation:

    $ psql
    # create role postgres with login createdb;
    # create database pg_app_name_test;
    # \q

Then get the development dependencies:

    $ bundle

And run the tests:

    $ rake spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
