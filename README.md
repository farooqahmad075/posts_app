# POSTS API APP

A JSON API service developed in Sinatra, Ruby.

## Technologies
* Ruby 2.7.4
* Bundler 2.2.9
* Sinatra 2.1.0
* Sequel 5.47.0
* Puma 5.4.0
* Postgres 13.0


## Development
### 1. Initial Setup
--------------------

Clone the project repo

    $ git clone https://github.com/farooq-dev075/posts_app.git

Get into the project directory

    $ cd posts_app
Install gems and their dependencies

    $ bundle install

### 2. Setting up ENV variables
-------------------------------
* Copy the environment variables example file

Use following command to do so

    $ cp .env.example .env

* Set the following ENV Variables in `.env` file
    DB_NAME, DB_USER, DB_PASSWORD, DB_HOST

### 3. Start Application Server
-------------------------------
Start the Application server

    $ bundle exec puma

