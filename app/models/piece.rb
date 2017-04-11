class Piece < ApplicationRecord
  belongs_to :game
  validates :color, inclusion: {
    in: %w(white black),
    message: '%{value} is not a valid color'
  }
  validates :active, inclusion: { in: [true, false] }
  validates :x_position, presence: true
  validates :y_position, presence: true
  validates :game_id, presence: true

  def obstructed_diagonally?(to_x:, to_y:)
    # Piece will move from (from_x, from_y) to (to_x, to_y)
    # First, find if there is something in the (to_x, to_y) space
    # This is for the case of moving one square away:
    return true if Piece.where(x_position: to_x, y_position: to_y, active: true).exists?
    false
  end
end
