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

  # Moving piece logic
  def move_tests(to_x:, to_y:)
    return true if valid_move?(to_x: to_x, to_y: to_y) &&
                   !obstructed_diagonally?(to_x: to_x, to_y: to_y) &&
                   !obstructed_horizontally?(to_x: to_x) &&
                   !obstructed_vertically?(to_y: to_y) &&
                   remains_on_board?(to_x: to_x, to_y: to_y)
    false
  end

  ### NOTE: DOESN'T WORK FOR PIECE WITH TYPE ###
  # Default move check to ensure that the piece moves
  def valid_move?(to_x:, to_y:)
    return true if to_x != x_position && to_y != y_position
    false
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

  def obstructed_vertically?(to_y:) # Not passing y_position as an argument; instead it is pulled from the object
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

  def remains_on_board?(to_x:, to_y:)
    if to_x >= 1 && to_x <= 8 && to_y >= 1 && to_y <= 8
      true
    else
      false
    end
  end

  def pieces_turn?
    game_of_piece = Game.find(game_id)
    return true if color == game_of_piece.current_color
    false
  end
end
