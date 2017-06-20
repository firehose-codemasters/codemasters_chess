class Game < ApplicationRecord
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User'
  has_many :pieces
  validates :name, presence: true
   # Need to communicate that each game has this
  validates :result, inclusion: {
    in: %w(in_progress white_win black_win draw),
    message: '%{value} is not a valid result'
  }
  validates :white_player, presence: true
  validates :black_player, presence: true

    # Game rules of chess
    def initialize_board_white_pieces
      (1..8).each do |index|
        Pawn.create(game_id: id, x_position: index, y_position: 2, color: 'white', active: true)
      end
      Rook.create(game_id: id, x_position: 1, y_position: 1, color: 'white', active: true)
      Knight.create(game_id: id, x_position: 2, y_position: 1, color: 'white', active: true)
      Bishop.create(game_id: id, x_position: 3, y_position: 1, color: 'white', active: true)
      Queen.create(game_id: id, x_position: 4, y_position: 1, color: 'white', active: true)
      King.create(game_id: id, x_position: 5, y_position: 1, color: 'white', active: true)
      Bishop.create(game_id: id, x_position: 6, y_position: 1, color: 'white', active: true)
      Knight.create(game_id: id, x_position: 7, y_position: 1, color: 'white', active: true)
      Rook.create(game_id: id, x_position: 8, y_position: 1, color: 'white', active: true)
    end

    def initialize_board_black_pieces
      (1..8).each do |index|
        Pawn.create(game_id: id, x_position: index, y_position: 7, color: 'black', active: true)
      end
      Rook.create(game_id: id, x_position: 1, y_position: 8, color: 'black', active: true)
      Knight.create(game_id: id, x_position: 2, y_position: 8, color: 'black', active: true)
      Bishop.create(game_id: id, x_position: 3, y_position: 8, color: 'black', active: true)
      Queen.create(game_id: id, x_position: 4, y_position: 8, color: 'black', active: true)
      King.create(game_id: id, x_position: 5, y_position: 8, color: 'black', active: true)
      Bishop.create(game_id: id, x_position: 6, y_position: 8, color: 'black', active: true)
      Knight.create(game_id: id, x_position: 7, y_position: 8, color: 'black', active: true)
      Rook.create(game_id: id, x_position: 8, y_position: 8, color: 'black', active: true)
    end

    def next_turn
      cc_stager = current_color
      rc_stager = resting_color
      update(current_color: rc_stager)
      update(resting_color: cc_stager)
    end
    
end
