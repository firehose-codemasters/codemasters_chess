class Queen < Piece
  def valid_move?(to_x:, to_y:)

    return false unless super(to_x: to_x, to_y: to_y) # calls parent method (on Piece) with same name
    # If the move isn't an overall Piece valid move, don't do the rest of the Queen logic
    # "super" calls the method of the same name from the parent class
    # so here it calls like Piece.valid_move?

    diag_vert = (to_y - y_position).abs
    diag_horz = (to_x - x_position).abs
    diag_delta = diag_vert - diag_horz
    return true if diag_horz != 0 && to_y == y_position
    return true if diag_vert != 0 && to_x == x_position
    return true if diag_delta.zero?
    false
  end
end
