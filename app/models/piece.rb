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

  # Moving piece logic (possibly add pieces_turn to the end of the return true if statement)
  def move_tests(to_x:, to_y:)
    return true if valid_move?(to_x: to_x, to_y: to_y) &&
                   !obstructed_diagonally?(to_x: to_x, to_y: to_y) &&
                   !obstructed_horizontally?(to_x: to_x) &&
                   !obstructed_vertically?(to_y: to_y) &&
                   remains_on_board?(to_x: to_x, to_y: to_y) &&
                   did_it_move?(to_x: to_x, to_y: to_y) &&
                   move_result(to_x: to_x, to_y: to_y) == 'success' ||
                   move_result(to_x: to_x, to_y: to_y) == 'kill'
    false
  end

  def valid_move?(*)
    true
  end

  def did_it_move?(to_x:, to_y:)
    return true if to_x != x_position || to_y != y_position
    false
  end

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
      return true if piece_at(current_x, current_y).present?
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
      return true if piece_at(x_position, current_y).present?
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
      return true if piece_at(current_x, y_position).present?
    end
    false
  end

  def remains_on_board?(to_x:, to_y:)
    return true if to_x >= 1 && to_x <= 8 && to_y >= 1 && to_y <= 8
    false
  end

  def move_result(to_x:, to_y:)
    # Valid move: destination square is open
    return 'success' if piece_at(to_x, to_y).nil?

    # Valid move with enemy piece captured at destination
    if type != 'pawn' && piece_at(to_x, to_y).present? && !piece_at(to_x, to_y).pieces_turn?
      return 'kill'
    end

    # Invalid move: teammate piece is at destination
    return 'failed' if piece_at(to_x, to_y).present? && piece_at(to_x, to_y).pieces_turn?
  end

  def pieces_turn?
    return true if color == game_of_piece.current_color
    false
  end

  def game_of_piece
    Game.find(game_id)
  end

  def piece_at(x, y)
    game_of_piece.pieces.find_by(x_position: x, y_position: y, active: true)
  end

  def kill
    update(active: false)
  end
end
