# Defines King type Piece and valid movements
class King < Piece
  def valid_move?(to_x:, to_y:)
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs.zero?
    return true if (to_x - x_position).abs.zero? && (to_y - y_position).abs == 1
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
    false
  end
end

# move validation for check... not a valid move if the king remains in check
# doesn't let another piece move if the king is in check and the moving piece
# doesn't block