require('sinatra')
require('sinatra/contrib/all') if development?
require('pry')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')
require_relative('models/ticket')
also_reload('models/*')

get '/index' do
    @films = Film.all()
    erb(:index)
end

films = Film.all()

get '/films/1' do
    @film = films[0]
    erb(:film_details)
end

get '/films/2' do
    @film = films[1]
    erb(:film_details)
end

get '/films/3' do
    @film = films[2]
    erb(:film_details)
end