class Game < ApplicationRecord
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User'
  validates :name, presence: true
  has_many :pieces # Need to communicate that each game has this
  validates :result, inclusion: {
    in: %w(in_progress white_win black_win draw),
    message: '%{value} is not a valid result'
  }
  validates :white_player, presence: true
  validates :black_player, presence: true
end
# Game rules of chess
def initialize_board_white_pieces
  (1..8).each do |_index|
    Pawn.create(game_id: id, x_position: 1, y_position: 2, color: 'white')
  end
  Rook.create(game_id: id, x_position: 1, y_position: 1, color: 'white')
  Knight.create(game_id: id, x_position: 2, y_position: 1, color: 'white')
  Bishop.create(game_id: id, x_position: 3, y_position: 1, color: 'white')
  Queen.create(game_id: id, x_position: 4, y_position: 1, color: 'white')
  King.create(game_id: id, x_position: 5, y_position: 1, color: 'white')
  Bishop.create(game_id: id, x_position: 6, y_position: 1, color: 'white')
  Knight.create(game_id: id, x_position: 7, y_position: 1, color: 'white')
  Rook.create(game_id: id, x_position: 8, y_position: 1, color: 'white')
end

def initialize_board_black_pieces
  (1..8).each do |_index|
    Pawn.create(game_id: id, x_position: 1, y_position: 7, color: 'black')
  end
  Rook.create(game_id: id, x_position: 1, y_position: 8, color: 'black')
  Knight.create(game_id: id, x_position: 2, y_position: 8, color: 'black')
  Bishop.create(game_id: id, x_position: 3, y_position: 8, color: 'black')
  Queen.create(game_id: id, x_position: 4, y_position: 8, color: 'black')
  King.create(game_id: id, x_position: 5, y_position: 8, color: 'black')
  Bishop.create(game_id: id, x_position: 6, y_position: 8, color: 'black')
  Knight.create(game_id: id, x_position: 7, y_position: 8, color: 'black')
  Rook.create(game_id: id, x_position: 8, y_position: 8, color: 'black')
end
