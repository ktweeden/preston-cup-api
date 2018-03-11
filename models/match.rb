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

  def populate_extra_info
    populate_game
    populate_participants
  end

  def populate_game
    @game = Game.find_by_id(@game_id)
    self
  end

  def populate_participants
    sql = "
    SELECT players.*, match_winners.player_id AS winner_id FROM players
    INNER JOIN match_players ON match_players.player_id = players.id
    LEFT JOIN match_winners ON match_winners.player_id = players.id
    WHERE match_players.match_id = $1;"
    values = [@id]
    results = execute_query(sql, values)
    winners = results.find_all{|player| player['winner_id'] != nil }
    results.each do |player|
      player_model =  Player.new(player)
      @players.push(player_model)
      @winners.push(player_model) if winners.find{|winner| player_model.id == winner['id']}
    end

    self
  end

  def Match.all
    sql = "SELECT * FROM matches;"
    results = execute_query(sql)
    results.map {|match| Match.new(match)}
  end

end
