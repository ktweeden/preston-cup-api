require_relative "../db/utils"

class Match

  attr_reader :id, :game_id, :date

  def initialize(options)
    @id = options.fetch('id', nil)
    @game_id = options['game_id']
    @date = Date.parse(options['date'])
  end

  def add_player(id)
    sql = "
    INSERT INTO match_players
    (match_id, player_id)
    VALUES
    ($1, $2);
    "
    values = [@id, id]
    execute_query(sql, values)
  end

  def add_winner(id)
    sql = "
    INSERT INTO match_winners
    (match_id, player_id)
    VALUES
    ($1, $2);
    "
    values = [@id, id]
    execute_query(sql, values)
  end

  def insert
    sql = "
    INSERT INTO matches
    (game_id, date)
    VALUES
    ($1, $2)
    RETURNING *;
    "
    values = [@game_id, @date]
    result = execute_query(sql, values).first
    Match.new(result)
  end

  def Match.all
    sql = "SELECT * FROM matches;"
    results = execute_query(sql)
    results.map {|match| Match.new(match)}
  end

end
