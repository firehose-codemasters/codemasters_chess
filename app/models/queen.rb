class Queen < Piece
  def valid_queen_move?(to_x:, to_y:)
    diag_vert = (to_y - y_position).abs
    diag_horz = (to_x - x_position).abs
    diag_delta = diag_vert - diag_horz
    return true if diag_horz != 0 && to_y == y_position
    return true if diag_vert != 0 && to_x == x_position
    return true if diag_delta.zero?
    false
  end
end
