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
end
