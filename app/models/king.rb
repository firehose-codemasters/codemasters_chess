# Defines King type Piece and valid movements
class King < Piece
  def valid_move?(to_x:, to_y:)
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs.zero?
    return true if (to_x - x_position).abs.zero? && (to_y - y_position).abs == 1
    return true if (to_x - x_position).abs == 1 && (to_y - y_position).abs == 1
    false
  end

  def kings_team
    @kings_pieces = Piece.where(color: color, game_id: game_id)
  end

  def possible_moves
    coords = []
    8.times do 
      coords << [*1..8]
    end
    coords.each_with_index do |i, j|
      i.each do |t|
        # t is the x, i[j] is the y
        @kings_pieces.each do |test_piece|
          puts test_piece.inspect
          puts test_piece.move_tests(to_x: t, to_y: i[j])
        end
      end
    end
  end
end
