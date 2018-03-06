require_relative "../db/utils"

class Game

  attr_reader :id, :name, :image_url

  def initialize(options)
    @id = options.fetch("id", nil)
    @name = options["name"]
    @image_url = options.fetch("image_url", nil)
  end

  def insert
    sql = "
    INSERT INTO games
    (name, image_url)
    VALUES
    ($1, $2)
    RETURNING *;
    "
    values = [@name, @image_url]
    result = execute_query(sql, values).first
    Game.new(result)
  end

end
