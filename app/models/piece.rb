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

  def obstructed?(to_x:, to_y:)
    valid_move?(to_x: to_x, to_y: to_y) &&
      unobstructed_horizontally?(to_x: to_x, to_y: to_y) &&
      unobstructed_vertically?(to_x: to_x, to_y: to_y) &&
      unobstructed_diagonally?(to_x: to_x, to_y: to_y)
  end

  def valid_move?(to_x:, to_y:)
    return false if to_x < 0
    return false if to_y < 0
  end

  def unobstructed_horizontally?(to_x:, to_y:)
    !obstructed_horizontally?(to_x: to_x, to_y: to_y)
  end

  def obstructed_horizontally?(to_x:, to_y:)
    return false unless valid_move(to_x: to_x, to_y: to_y)
    raise 'TODO'
  end

  def unobstructed_vertically?(to_x:, to_y:)
    !obstructed_vertically?(to_x: to_x, to_y: to_y)
  end

  def obstructed_vertically?(to_x:, to_y:)
    return false unless valid_move(to_x: to_x, to_y: to_y)
    raise 'TODO'
  end

  def unobstructed_diagonally?(to_x:, to_y:)
    !obstructed_diagonally?(to_x: to_x, to_y: to_y)
  end

  def obstructed_diagonally?(to_x:, to_y:)
    return false unless valid_move(to_x: to_x, to_y: to_y)
    raise 'TODO'
  end
end
