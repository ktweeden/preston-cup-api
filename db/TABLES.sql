DROP TABLE IF EXISTS match_winners;
DROP TABLE IF EXISTS match_players;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS games;

CREATE TABLE games (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  image_url VARCHAR(255)
);

CREATE TABLE players (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  avatar_url VARCHAR(255)
);

CREATE TABLE matches (
  id SERIAL4 PRIMARY KEY,
  game_id INT4 REFERENCES games NOT NULL,
  date DATE NOT NULL
);

-- joins matches to participant players
CREATE TABLE match_players (
  id SERIAL4 PRIMARY KEY,
  match_id INT4 REFERENCES matches NOT NULL,
  player_id INT4 REFERENCES players NOT NULL
);

-- joins matches to winning players
CREATE TABLE match_winners (
  id SERIAL4 PRIMARY KEY,
  match_id INT4 REFERENCES matches NOT NULL,
  player_id INT4 REFERENCES players NOT NULL
);
