require "pry"
require_relative "./models/game"


catan = Game.new({"name" => "Settlers of Catan"})

catan.insert


binding.pry


nil
