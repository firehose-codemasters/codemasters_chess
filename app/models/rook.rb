class Rook < Piece
  def valid_move?(to_x:, to_y:)
    return true if to_y == y_position || to_x == x_position
    false
  end
end
