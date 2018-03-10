require_relative '../models/game'
require_relative '../models/match'
require_relative '../models/player'

players = [
  Player.new({'name' => 'Jack', 'avatar_url' => 'https://www.placecage.com/200/300'}),
  Player.new({'name' => 'Katie', 'avatar_url' => 'https://www.placecage.com/c/200/300'})
]
players = players.map {|player| player.insert}

games = [
  Game.new({'name' => 'Settlers of Catan', 'image_url' => 'https://www.placecage.com/200/300'}),
  Game.new({'name' => 'Pandemic', 'image_url' => 'https://www.placecage.com/200/300'}),
  Game.new({'name' => 'Dominion', 'image_url' => 'https://www.placecage.com/200/300'}),
  Game.new({'name' => 'Oh! My Goods', 'image_url' => 'https://www.placecage.com/200/300'}),
  Game.new({'name' => 'Bananagrams', 'image_url' => 'https://www.placecage.com/200/300'}),
  Game.new({'name' => 'Pixel Tactics', 'image_url' => 'https://www.placecage.com/200/300'})
]
games = games.map {|game| game.insert}

matches = [
  Match.new({'game_id' => games[0].id, 'date' => '2018-01-01'}),
]
matches = matches.map {|match| match.insert}

matches[0].add_player(players[0].id)
matches[0].add_player(players[1].id)
matches[0].add_winner(players[0].id)
