class Queen < Piece
  def valid_move?(to_x:, to_y:)
    dist_vert = (to_y - y_position).abs
    dist_horz = (to_x - x_position).abs
    diag_delta = dist_vert - dist_horz

    diag_delta.zero? ||
      (dist_horz != 0 && to_y == y_position) ||
      (dist_vert != 0 && to_x == x_position)
  end
end
