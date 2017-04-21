# Defines King type Piece and valid movements
class King < Piece
  def valid_move?(to_x:, to_y:)
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs.zero?
    return true if (to_x - x_position).abs.zero? && (to_y - y_position).abs == 1
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
    'You may move the king only one square from its current location! Please try again.'
  end
end
