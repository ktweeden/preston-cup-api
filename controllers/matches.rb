require 'sinatra'
require 'sinatra/contrib/all'

require_relative '../models/match'

get '/matches' do
  @matches = Match.all.map {|match| match.populate_extra_info}
  erb(:"matches/index")
end
