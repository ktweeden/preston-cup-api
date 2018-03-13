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
    @id = execute_query(sql, values).first['id']
    self
  end


  def Game.all
    sql = "SELECT * FROM games
    ORDER BY name;"
    results = execute_query(sql)
    results.map {|game| Game.new(game)}
  end

  def Game.find_by_id(id)
    sql = "SELECT * FROM games WHERE id = $1;"
    Game.new(execute_query(sql, [id]).first)
  end

end
