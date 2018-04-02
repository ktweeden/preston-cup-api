require_relative "../db/utils"

class Player

  attr_reader :id, :name, :avatar_url, :total_matches_won, :matches_won_by_game

  def initialize(options)
    @id = options.fetch("id", nil)
    @name = options["name"]
    @avatar_url = options.fetch("avatar_url", nil)
    @total_matches_won = 0
    @matches_won_by_game = []
  end

  def insert
    sql = "
    INSERT INTO players
    (name, avatar_url)
    VALUES
    ($1, $2)
    RETURNING *;
    "
    values = [@name, @avatar_url]
    @id = execute_query(sql, values).first['id']
    self
  end

  def get_matches_won_by_game
    sql = "
    SELECT
      COUNT(match_winners.player_id) AS matches_won,
      games.id AS game_id,
      games.name AS game_name,
      games.image_url AS game_image_url
    FROM match_winners
    INNER JOIN matches ON match_winners.match_id = matches.id
    INNER JOIN games ON matches.game_id = games.id
    WHERE match_winners.player_id = $1
    GROUP BY games.id
    ORDER BY matches_won DESC;
    "
    execute_query(sql, [@id])
  end

  def get_total_matches_won
    sql = "
    SELECT COUNT(player_id)
    FROM match_winners
    WHERE player_id = $1;"
    execute_query(sql, [@id]).first['count']
  end

  def populate_stats
    @total_matches_won = get_total_matches_won
    @matches_won_by_game = get_matches_won_by_game
    self
  end

  def Player.all
    sql = "SELECT * FROM players
    ORDER BY name;"
    results = execute_query(sql)
    results.map {|player| Player.new(player)}
  end

end
