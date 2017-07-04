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
    if type != 'pawn' && piece_at(to_x, to_y).present? && piece_at(to_x, to_y).color != color
      return 'kill'
    end

    # Invalid move: teammate piece is at destination
    return 'failed' if piece_at(to_x, to_y).present? && piece_at(to_x, to_y).color == color
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

  def revive
    update(active: true)
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

  def checkmate?
    # Create a hash of the initial placement of pieces on the board (initial conditions)
    initial_board_state = [*offense, *defense].index_by(&:id)

    # Iterate through each move that the current_color can make
    possible_moves(offense).each do |move|
      piece_id = move[0]
      to_x = move[1]
      to_y = move[2]
      threat = piece_at(to_x, to_y)
      # For each piece in the iteration, update the piece's location to the move's destination and
      # see if the king is still in check
      Piece.find(piece_id).update(x_position: to_x, y_position: to_y)

      # In case of a secondary threat, temporarily kill enemy piece
      threat&.kill if threat&.color != color

      # Not in checkmate if current_color can make a move that doesn't result in check
      return false unless in_check?(game_of_piece.current_color)

      ### Restore the board back to its initial condition ###
      # restore the moved piece to its original position
      Piece.find(piece_id).update(x_position: initial_board_state.fetch(piece_id).x_position,
                                  y_position: initial_board_state.fetch(piece_id).y_position)
      # If there was a threat that was killed, revive it (the & checks if the threat was nil or not)
      threat&.revive
      ### Board is now back in initial condition
    end
    true
  end
end
