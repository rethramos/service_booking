# Service Booking

A booking management platform for businesses and customers.

## System dependencies

* Ruby >= 3.1.2
* Node >= 16.17.0
* PostgreSQL >= 14.6

## Configuration

1. Install [Ruby on Rails](https://gorails.com/guides).
1. Install [Yarn](https://yarnpkg.com/).
1. Open a terminal and clone this repository (https://github.com/rethramos/service_booking.git).
1. Run `bundle install` to install the Rails project.
1. Run `yarn install` to install the frontend dependencies.

## Developing locally

1. Make sure the `config/master.key` file is present and correct (contact the owner if necessary).
1. Run `bin/dev` to start the server and other dev processes.
1. You can now access the web app at `localhost:3000`.

## Database creation and initialization

1. Run `rails db:setup`.

## Running tests

1. Run `rails test`.

## Deployment

[Heroku](https://www.heroku.com/) is the recommended way of deploying this application.
