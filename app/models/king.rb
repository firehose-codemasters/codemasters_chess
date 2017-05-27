# Defines King type Piece and valid movements
class King < Piece
  attr_accessor :kings_pieces

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
    possible_moves = []
    # initialize an 8x8 array of coordinates 1-8
    coords = Array.new(8) { [*1..8] }
    coords.each_with_index do |i, j|
      i.each do |t|
        # t is the x, i[j] is the y
        @kings_pieces.each do |test_piece|
          # Run move validation tests on every piece
          next unless test_piece.move_tests(to_x: t, to_y: i[j])
            # if a move passes validations, push the pieces ID and the
            # coordinates of a successful move to the possible_moves array
            possible_moves << [test_piece.id, t, i[j]]
        end
      end
    end
    possible_moves
  end

  def checkmate?
    ## Run a test to see if the king is in check for each of the
    # moves listed in the "possible_moves" array.
    # This method should return 'true' if every single one of those
    # possible moves comes back as "king is still in check", because that means
    # that no matter what moves the player who is in check makes, they cannot
    # get out of check.
    #
    # Possible approach to test once check method is done:
    #
    # possible_moves.each do |move|
    #   return false unless check?(piece_id: move[0], to_x: move[1], to_y: move[2])}
    #   true
    # end
  end
end
