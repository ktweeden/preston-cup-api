require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/player'

get '/players/stats' do
  @players = Player.all.map {|player| player.populate_stats}
  erb(:"players/stats")
end
