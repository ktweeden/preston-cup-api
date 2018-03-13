require_relative "../db/utils"
require_relative "./player"
require_relative "./game"

class Match

  attr_reader :id, :game_id, :date, :players, :winners, :game

  def initialize(options)
    @id = options.fetch('id', nil)
    @game_id = options['game_id']
    @date = Date.parse(options['date'])
    @players = []
    @winners = []
    @game = nil
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
    @id = execute_query(sql, values).first['id']
    self
  end

  def player_is_winner?(player_id)
    @winners.any?{|winner| player_id == winner.id}
  end

  def populate_extra_info
    populate_game
    populate_participants
  end

  def populate_game
    @game = Game.find_by_id(@game_id)
    self
  end

  def populate_participants
    populate_players
    populate_winners
  end

  def populate_players
    sql = "
    SELECT players.* FROM players
    INNER JOIN match_players ON match_players.player_id = players.id
    WHERE match_players.match_id = $1;"
    @players = execute_query(sql, [@id]).map {|player| Player.new(player)}
    self
  end

  def populate_winners
    sql = "
    SELECT players.* FROM players
    INNER JOIN match_winners ON match_winners.player_id = players.id
    WHERE match_winners.match_id = $1;"
    @winners = execute_query(sql, [@id]).map {|winner| Player.new(winner)}
    self
  end

  def Match.all
    sql = "SELECT * FROM matches;"
    results = execute_query(sql)
    results.map {|match| Match.new(match)}
  end

end
