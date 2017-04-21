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

  # These methods help to define the prototypical Piece concept/object
  def valid_move?(to_x:, to_y:)
    return false if # distance_traveled > max_move_distance 
    return false if # move goes off the board
    # Should check that distance traveled is at least 1
    true # default 
  end

  def distance_traveled(to_x:, to_y:)
    # Checks to see how far a piece moves
    # 
  end

  def maximum_move_distance
    return 8 # Could RAISE "not implemented" error - this should be overridden by 
    # each Type's max move distance. Not really implemented for generic class "Piece"
  end

  def obstructed_diagonally?(to_x:, to_y:)
    # Current_x and current_y are used as incrementer variables
    current_x = x_position
    current_y = y_position
    #
    # Use this IF when destination is up-right
    if to_x > x_position && to_y > y_position
      until current_x == to_x && current_y == to_y
        current_x += 1
        current_y += 1
        return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
      end
    end
    #
    # Use this IF when destination is down-left
    if to_x < x_position && to_y < y_position
      until current_x == to_x && current_y == to_y
        current_x -= 1
        current_y -= 1
        return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
      end
    end
    #
    # Use this IF when destination is up-left
    if to_x < x_position && to_y > y_position
      until current_y == to_y && current_x == to_x
        current_x -= 1 if current_x != to_x
        current_y += 1 if current_y != to_y
        return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
      end
    end
    #
    # Use this IF when destination is down-right
    if to_x > x_position && to_y < y_position
      until current_y == to_y && current_x == to_x
        current_x += 1 if current_x != to_x
        current_y -= 1 if current_y != to_y
        return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
      end
    end
    false
  end

  def obstructed_vertically?(to_y:)
    current_y = y_position
    if current_y < to_y
      while current_y < to_y
        current_y += 1
        return true if Piece.where(y_position: current_y, active: true).exists?
      end
    else
      while current_y > to_y
        current_y -= 1
        return true if Piece.where(y_position: current_y, active: true).exists?
      end
    end
    false
  end

  def obstructed_horizontally?(to_x:)
    current_x = x_position
    # if method for moving piece to the right
    if current_x < to_x
      while current_x < to_x
        current_x += 1
        return true if Piece.where(x_position: current_x, active: true).exists?
      end
    # else method for movie piece to the left
    else
      while current_x > to_x
        current_x -= 1
        return true if Piece.where(x_position: current_x, active: true).exists?
      end
    end
    false
  end
end
