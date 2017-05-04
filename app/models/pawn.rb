class Pawn < Piece
  def valid_pawn_move?(to_x:, to_y:)
    return true if normal_move?(to_x, to_y)
    return true if first_move?(to_x, to_y) # How do we keep track of first move
    return true if pawn_diagonal?(to_x, to_y)
    false
  end

  private

  # Returns true if the pawn advances one space from its origin
  def normal_move?(to_x, to_y)
    return true if color == 'black' && to_y - y_position == -1 && to_x == x_position
    return true if color == 'white' && to_y - y_position == 1 && to_x == x_position
    false
  end

  def pawn_diagonal?(to_x, to_y)
    (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
  end

  def first_move?(to_x, to_y)
    (to_y - y_position).abs == 1 || (to_y - y_position).abs == 2 && (to_x - x_position).abs == 0
  end
end
