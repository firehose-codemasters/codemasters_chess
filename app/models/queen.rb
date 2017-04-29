class Queen < Piece
  def valid_move?(to_x:, to_y:)
    dist_vert = (to_y - y_position).abs
    dist_horz = (to_x - x_position).abs
    diag_delta = dist_vert - dist_horz
    return true if dist_horz != 0 && to_y == y_position
    return true if dist_vert != 0 && to_x == x_position
    return true if diag_delta.zero?
    false
  end
end
