require('sinatra')
require('sinatra/contrib/all') if development?
require('pry')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')
require_relative('models/ticket')
also_reload('models/*')

get '/films' do
    @films = Film.all()
    erb(:films)
end

get '/films/:id' do
    @film = Film.find_by_id(params[:id].to_i)
    erb(:film_details)
end