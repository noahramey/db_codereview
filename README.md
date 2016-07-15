# _hair salon_

##### This application is used to showcase what I've learned about database basics, CRUD, and RESTful routes in the form of a hair salon site.

## Technologies Used

Application: Ruby, Sinatra<br>
Testing: Rspec, Capybara<br>
Database: Postgres

Installation
------------

First clone the repository.  
```
$ git clone https://github.com/noahramey/db_codereview
```

Install required gems:
```
$ bundle install
```

In PSQL:
```
CREATE DATABASE hair_salon;
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
```

Start the webserver:
```
$ ruby app.rb
```

Open `localhost:4567` in browser.

License
-------

MIT License. Copyright &copy; 2016 "Noah Ramey"
