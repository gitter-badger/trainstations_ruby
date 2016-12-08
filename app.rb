require("sinatra")
require("sinatra/reloader")
require('./lib/city')
require('./lib/train')
also_reload("./lib/**/*.rb")
require('pg')

DB = PG.connect({:dbname => 'trainstations_test'})


get('/') do
  erb(:index)
end

get('/admin') do
  @trains = Train.all()
  @cities = City.all()
  erb(:admin)
end

get('/train_new') do
  erb(:train_form)
end

post('/trains') do
  route = params.fetch('route')
  Train.new({:route => route}).save()
  @trains = Train.all()
  @cities = City.all()
  erb(:admin)
end

get('/admin/train/:id') do
  id = params.fetch('id').to_i
  @train = Train.find(id)
  # FIX THIS!!!
  # @cities = @train.cities()
  @cities = City.all()
  erb(:train)
end

get('/city_new')do
  erb(:city_form)
end

post('/cities') do
  name = params.fetch('name')
  City.new({:name => name}).save()
  @cities = City.all()
  @trains = Train.all()
  erb(:admin)
end

get('/admin/city/:id')do
  id = params.fetch('id').to_i
  @city = City.find(id)
  erb(:city)
end

delete("/admin/train/:id") do
  @train = Train.find(params.fetch("id").to_i)
  @train.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:admin)
end

get("/admin/train/:id/edit") do
  @train = Train.find(params.fetch("id").to_i)
  erb(:train_edit)
end

patch('/admin/train/:id')do
  route = params.fetch("route")
  @train = Train.find(params.fetch("id").to_i)
  @train.update({:route => route})
  @cities = City.all()
  erb(:train)
end

delete("/admin/city/:id") do
  @city = City.find(params.fetch("id").to_i)
  @city.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:admin)
end

get("/admin/city/:id/edit") do
  @city = City.find(params.fetch("id").to_i)
  erb(:city_edit)
end

patch('/admin/city/:id')do
  name = params.fetch("name")
  @city = City.find(params.fetch("id").to_i)
  @city.update({:name => name})
  erb(:city)
end


#customer related

get('/customer') do
  @trains = Train.all()
  @cities = City.all()
  erb(:customer)
end

post('/admin/trains/:id') do
  train_id = params.fetch('id').to_i
  city_id = params.fetch('city_id').to_i
  @city = City.find(city_id)
  @train = Train.find(train_id)

  @train.add_city({:city_id => city_id})
  @trains = Train.all()
  @cities = City.all()
  erb(:train)
end
