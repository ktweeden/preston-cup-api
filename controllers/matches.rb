require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/match'
require_relative '../models/game'

get '/matches' do
  @matches = Match.all.map {|match| match.populate_extra_info}
  erb(:"matches/index")
end

get '/matches/add' do
  @games = Game.all
  @players = Player.all
  erb(:"matches/add")
end

post '/matches' do
  players = Player.all
  match = Match.new(params).insert
  players.each {|player| match.add_player(player.id)}
  match.add_winner(params['winner_id'])
  p match
  redirect '/matches'
end
