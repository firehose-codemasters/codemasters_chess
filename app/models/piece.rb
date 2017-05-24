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
    # Current_x and current_y are used as incrementer variables
    current_x = x_position
    current_y = y_position
    # distance_travelled for 'y' is always == distance travelled for 'x'
    distance_travelled = (to_y - y_position).abs - 1
    distance_travelled.times do
      if to_y > y_position && to_x > x_position # Move up and to the right
        current_y += 1
        current_x += 1
      elsif to_y > y_position && to_x < x_position # Move up and to the left
        current_y += 1
        current_x -= 1
      elsif to_y < y_position && to_x > x_position # Move down and to the right
        current_y -= 1
        current_x += 1
      else
        current_y -= 1
        current_x -= 1
      end
      return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
    end
    false
  end

  def obstructed_vertically?(to_y:) # Not passing y_position as an argument; instead it is pulled from the object
    current_y = y_position
    distance_travelled = (to_y - y_position).abs - 1
    distance_travelled.times do
      if to_y > y_position
        current_y += 1
      else
        current_y -= 1
      end
      return true if Piece.where(y_position: current_y, active: true).exists?
    end
    false
  end

  def obstructed_horizontally?(to_x:)
    current_x = x_position
    distance_travelled = (to_x - x_position).abs - 1
    distance_travelled.times do
      if to_x > x_position
        current_x += 1
      else
        current_x -= 1
      end
      return true if Piece.where(x_position: current_x, active: true).exists?
    end
    false
  end

  def remains_on_board?(to_x:, to_y:)
    return true if to_x >= 1 && to_x <= 8 && to_y >= 1 && to_y <= 8
    false
  end

  def capture(to_x:, to_y:)
    target_piece = Piece.find_by(x_position: to_x, y_position: to_y, active: true)
    # Valid move: destination square is open
    return 'success' if target_piece.nil?

    # Valid move with enemy piece captured at destination
    if !target_piece.nil? && !target_piece.pieces_turn?
      target_piece.update(active: false)
      return 'success'
    end

    # Invalid move: teammate piece is at destination
    return 'failed' if !target_piece.nil? && target_piece.pieces_turn?
  end

  def pieces_turn?
    game_of_piece = Game.find(game_id)
    return true if color == game_of_piece.current_color
    false
  end
end
