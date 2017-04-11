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
  8.times do
    Pawn.create(game_id: id, x_position: 2, y_position: 1, color: true)
  end
  Rook.create(game_id: id, x_position: 1, y_position: 1, color: true)
  Knight.create(game_id: id, x_position: 1, y_position: 2, color: true)
  Bishop.create(game_id: id, x_position: 1, y_position: 3, color: true)
  Queen.create(game_id: id, x_position: 1, y_position: 4, color: true)
  King.create(game_id: id, x_position: 1, y_position: 5, color: true)
  Bishop.create(game_id: id, x_position: 1, y_position: 6, color: true)
  Knight.create(game_id: id, x_position: 1, y_position: 7, color: true)
  Rook.create(game_id: id, x_position: 1, y_position: 8, color: true)
end

def initialize_board_black_pieces
  8.times do
    Pawn.create(game_id: id, x_position: 7, y_position: 1, color: true)
  end
  Rook.create(game_id: id, x_position: 8, y_position: 1, color: true)
  Knight.create(game_id: id, x_position: 8, y_position: 2, color: true)
  Bishop.create(game_id: id, x_position: 8, y_position: 3, color: true)
  Queen.create(game_id: id, x_position: 8, y_position: 4, color: true)
  King.create(game_id: id, x_position: 8, y_position: 5, color: true)
  Bishop.create(game_id: id, x_position: 8, y_position: 6, color: true)
  Knight.create(game_id: id, x_position: 8, y_position: 7, color: true)
  Rook.create(game_id: id, x_position: 8, y_position: 8, color: true)
end
