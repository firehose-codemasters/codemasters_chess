class Knight < Piece
  def obstructed_diagonally?(*)
    false   # Because a knight can "jump over" any piece in its path
  end

  def obstructed_vertically?(*)
    false   # Because a knight can "jump over" any piece in its path
  end

  def obstructed_horizontally?(*)
    false   # Because a knight can "jump over" any piece in its path
  end

  def valid_move?(to_x:, to_y:)
    return true if (to_x - x_position).abs == 2 && (to_y - y_position).abs == 1
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 2
    false
  end
end
