require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/game'

get '/games/add' do
  erb(:"games/add")
end

post '/games' do
  Game.new(params).insert
  redirect '/'
end
