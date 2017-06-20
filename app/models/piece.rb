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

  def move_tests(to_x:, to_y:)
    return true if valid_move?(to_x: to_x, to_y: to_y) &&
                   !obstructed_diagonally?(to_x: to_x, to_y: to_y) &&
                   !obstructed_horizontally?(to_x: to_x) &&
                   !obstructed_vertically?(to_y: to_y) &&
                   remains_on_board?(to_x: to_x, to_y: to_y) &&
                   did_it_move?(to_x: to_x, to_y: to_y) &&
                   # edited: this version for conflicts
                   (move_result(to_x: to_x, to_y: to_y) == 'success' ||
                   move_result(to_x: to_x, to_y: to_y) == 'kill')
    false
  end

  # final move aggregator... could be moved to the controller as two separate calls
  def secondary_move_tests(to_x:, to_y:)
    return true if move_tests(to_x: to_x, to_y: to_y) == true &&
                   in_check?(game_of_piece.current_color) == false
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
      return true if Piece.where(y_position: current_y, x_position: x_position, active: true).exists?
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
      return true if Piece.where(x_position: current_x, y_position: y_position, active: true).exists?
    end
    false
  end

  def remains_on_board?(to_x:, to_y:)
    return true if to_x >= 1 && to_x <= 8 && to_y >= 1 && to_y <= 8
    false
  end

  def move_result(to_x:, to_y:)
    # Valid move: destination square is open
    return 'success' if target_piece(to_x: to_x, to_y: to_y).nil?

    # this version for conflict
    # Valid move with enemy piece captured at destination
    if type != 'pawn' && !target_piece(to_x: to_x, to_y: to_y).nil? && target_piece(to_x: to_x, to_y: to_y).color != color
      return 'kill'
    end

    # this version for conflict
    # Invalid move: teammate piece is at destination
    return 'failed' if !target_piece(to_x: to_x, to_y: to_y).nil? && target_piece(to_x: to_x, to_y: to_y).color == color
  end

  ### private

  # delete for conflict
  # def pieces_turn?
  #   return true if color == game_of_piece.current_color
  #   false
  # end

  def game_of_piece
    Game.find(game_id)
  end

  def target_piece(to_x:, to_y:)
    Piece.find_by(x_position: to_x, y_position: to_y, game_id: game_id, active: true)
  end

  def kill
    update(active: false)
  end

  # begin methods needed for check

  # could be moved to game model
  def offense
    offensive_pieces = if game_of_piece.current_color == 'white'
                         Piece.where(color: 'white', game_id: game_id, active: true)
                       else
                         Piece.where(color: 'black', game_id: game_id, active: true)
                       end
    offensive_pieces
  end

  # could be moved to game model
  def defense
    defensive_pieces = if game_of_piece.current_color == 'white'
                         Piece.where(color: 'black', game_id: game_id, active: true)
                       else
                         Piece.where(color: 'white', game_id: game_id, active: true)
                       end
    defensive_pieces
  end

  # passing either offense or defense... could be moved to game model
  def possible_moves(side)
    possible_moves = []
    # initialize an 8x8 array of coordinates 1-8
    coords = Array.new(8) { [*1..8] }
    coords.each_with_index do |i, j|
      i.each do |t|
        # t is the x, i[j] is the y
        side.each do |test_piece|
          # Run move validation tests on every piece
          next unless test_piece.move_tests(to_x: t, to_y: i[j])
            # if a move passes validations, push the pieces ID and the
            # coordinates of a successful move to the possible_moves array
            possible_moves << [test_piece.id, t, i[j]]
        end
      end
    end
    possible_moves
  end

  # passing current_color or resting_color...  could be moved to king model
  def king_coords(side)
    king = game_of_piece.pieces.find_by(type: 'King', color: side)
    [king.x_position, king.y_position]
  end

  # passing current_color or resting_color
  def in_check?(side)
    if side == game_of_piece.resting_color
      possible_moves(offense).each do |move|
        next if king_coords(game_of_piece.resting_color)[0] != move[1] &&
                king_coords(game_of_piece.resting_color)[1] != move[2]
        return true if king_coords(game_of_piece.resting_color)[0] == move[1] &&
                       king_coords(game_of_piece.resting_color)[1] == move[2]
      end
    elsif side == game_of_piece.current_color
      possible_moves(defense).each do |move|
        next if king_coords(game_of_piece.current_color)[0] != move[1] &&
                king_coords(game_of_piece.current_color)[1] != move[2]
        return true if king_coords(game_of_piece.current_color)[0] == move[1] &&
                       king_coords(game_of_piece.current_color)[1] == move[2]
      end
    end
    false
  end

  # May need to be a separate method: Only move allowed is one that gets out of check if
  # above test returns true.
end
