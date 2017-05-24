class Pawn < Piece
  def valid_move?(to_x:, to_y:)
    return true if direction_of_white_and_black_pawns(to_y) &&
      (
        normal_move?(to_x, to_y) ||
        first_move?(to_x, to_y) ||
        pawn_diagonal?(to_x, to_y)
      )
    false
  end

  private

  # This logic makes sure that the pawn can only move forward
  # White pawns can only move *up* the board
  # Black pawns can only move *down* the board
  def direction_of_white_and_black_pawns(to_y)
    return true if color == 'white' && to_y > y_position
    return true if color == 'black' && to_y < y_position
    false
  end

  # Returns true if the pawn advances one space from its origin
  def normal_move?(to_x, to_y)
    return true if (to_y - y_position).abs == 1 && to_x == x_position
    false
  end

  # Returns true if the move is a valid capture by a pawn (i.e, diagonal one space):
  def pawn_diagonal?(to_x, to_y)
    target_piece = Piece.find_by(x_position: to_x, y_position: to_y, active: true)
    return 'failed' if (to_x - x_position).abs != 1 || (to_y - y_position).abs != 1 || target_piece.nil? || target_piece.pieces_turn?
    return 'success' if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1 && !target_piece.nil? && !target_piece.pieces_turn?
    target_piece.update(active: false)
  end

  # Returns true if it's the pawn's first move
  def first_move?(to_x, to_y)
    if color == 'black' && y_position == 7 || color == 'white' && y_position == 2
      return true if ((to_y - y_position).abs == 1 || (to_y - y_position).abs == 2) && to_x == x_position
    else
      false
    end
  end
end
