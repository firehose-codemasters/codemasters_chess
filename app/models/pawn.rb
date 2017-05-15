class Pawn < Piece
  def valid_pawn_move?(to_x:, to_y:)
    return true if direction_of_white_and_black_pawns(to_y) &&
      (
        normal_move?(to_x, to_y) ||
        first_move?(to_x, to_y) ||
        pawn_diagonal_capture?(to_x, to_y)
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

  # Returns true if the move is diagonal one space.
  def pawn_diagonal_capture?(to_x, to_y)
    captured_piece = (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
    return true if pawn_diagonal_capture && obstructed_diagonally?(to_x, to_y) != Piece.current_color
    return false if pawn_diagonal_capture == Piece.current_color && obstructed_diagonally?(to_x, to_y)
    return false if captured_piece.blank?
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
