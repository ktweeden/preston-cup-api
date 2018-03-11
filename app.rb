require 'sinatra'
require 'sinatra/contrib/all'

require_relative './models/game'
require_relative './models/player'
require_relative './models/match'


get '/' do
  @games = Game.all
  @matches = Match.all
  @players = Player.all
  erb(:home)
end
