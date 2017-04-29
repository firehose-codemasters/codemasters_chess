class Knight < Piece
  def obstructed_diagonally?(*)
    false
  end

  def obstructed_vertically?
    false
  end

  def obstructed_horizontally?
    false
  end

  def valid_move?(to_x:, to_y:)
    return true if (to_x - x_position).abs == 2 && (to_y - y_position).abs == 1
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 2
    'Knight may move only in an L shape, a total of 3 squares. Try again.'
  end
end
