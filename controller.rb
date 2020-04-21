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

get '/films/:page' do
    films = Film.all()
    index = params[:page].to_i - 1
    @film = films[index]
    erb(:film_details)
end