class Bishop < Piece
  def valid_move?(to_x:, to_y:)
    diag_checker = (to_y - y_position).abs - (to_x - x_position).abs
    return true if diag_checker.zero?
    false
  end
end
