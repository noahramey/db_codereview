require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/client')
require('./lib/stylist')
require('pg')

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  erb(:index)
end

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients/new') do
  erb(:client_form)
end

get('/stylists/new') do
  erb(:stylist_form)
end
