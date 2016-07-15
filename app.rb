require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/client')
require('./lib/stylist')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

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

get('/stylists/new') do
  erb(:stylist_form)
end

post('/clients') do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id').to_i()
  client = Client.new({name: name, stylist_id: stylist_id})
  client.save()
  @clients = Client.all()
  erb(:clients)
end

post('/stylists') do
  name = params.fetch('name')
  stylist = Stylist.new({name: name})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients/:id') do
  @client = Client.find(params.fetch('id').to_i())
  @stylists = Stylist.all()
  erb(:client)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  erb(:stylist)
end

get("/clients/:id/edit") do
  @client = Client.find(params.fetch("id").to_i())
  @stylists = Stylist.all()
  erb(:client_edit)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = Client.all()
  erb(:stylist_edit)
end

patch("/stylists/:id") do
  id = params.fetch("id").to_i()
  @stylist = Stylist.find(id)
  if params.fetch('name') == ""
    name = @stylist.name()
  else
    name = params.fetch('name')
  end
  @stylist.update({name: name})
  erb(:stylist)
end

patch("/clients/:id") do
  id = params.fetch("id").to_i()
  @client = Client.find(id)
  if params.fetch('name') == ""
    name = @client.name()
  else
    name = params.fetch('name')
  end
  stylist_id = params.fetch("stylist_id").to_i()
  @client.update({name: name, stylist_id: stylist_id})
  erb(:client)
end
