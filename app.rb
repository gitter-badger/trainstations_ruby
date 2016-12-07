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
  erb(:admin)
end
