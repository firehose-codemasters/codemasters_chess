class Piece < ApplicationRecord
  belongs_to :game
  validates :color, inclusion: {
    in: %w(white black),
    message: '%{value} is not a valid color'
  }
  validates :active, inclusion: { in: [true, false] }
  validates :x_position, presence: true
  validates :y_position, presence: true
  validates :game_id, presence: true

  # Moving piece logic (possibly add pieces_turn to the end of the return true if statement)
  def move_tests(to_x:, to_y:)
    return true if valid_move?(to_x: to_x, to_y: to_y) &&
                   !obstructed_diagonally?(to_x: to_x, to_y: to_y) &&
                   !obstructed_horizontally?(to_x: to_x) &&
                   !obstructed_vertically?(to_y: to_y) &&
                   remains_on_board?(to_x: to_x, to_y: to_y) &&
                   did_it_move?(to_x: to_x, to_y: to_y) &&
                   move_result(to_x: to_x, to_y: to_y) == 'success' ||
                   move_result(to_x: to_x, to_y: to_y) == 'kill'
    false
  end

  def valid_move?(*)
    true
  end

  def did_it_move?(to_x:, to_y:)
    return true if to_x != x_position || to_y != y_position
    false
  end

  def obstructed_diagonally?(to_x:, to_y:)
    # Current_x and current_y are used as incrementer variables
    current_x = x_position
    current_y = y_position
    # distance_travelled for 'y' is always == distance travelled for 'x'
    distance_travelled = (to_y - y_position).abs - 1
    distance_travelled.times do
      if to_y > y_position && to_x > x_position # Move up and to the right
        current_y += 1
        current_x += 1
      elsif to_y > y_position && to_x < x_position # Move up and to the left
        current_y += 1
        current_x -= 1
      elsif to_y < y_position && to_x > x_position # Move down and to the right
        current_y -= 1
        current_x += 1
      else
        current_y -= 1
        current_x -= 1
      end
      return true if Piece.where(x_position: current_x, y_position: current_y, active: true).exists?
    end
    false
  end

  def obstructed_vertically?(to_y:) # Not passing y_position as an argument; instead it is pulled from the object
    current_y = y_position
    distance_travelled = (to_y - y_position).abs - 1
    distance_travelled.times do
      if to_y > y_position
        current_y += 1
      else
        current_y -= 1
      end
      return true if Piece.where(y_position: current_y, active: true).exists?
    end
    false
  end

  def obstructed_horizontally?(to_x:)
    current_x = x_position
    distance_travelled = (to_x - x_position).abs - 1
    distance_travelled.times do
      if to_x > x_position
        current_x += 1
      else
        current_x -= 1
      end
      return true if Piece.where(x_position: current_x, active: true).exists?
    end
    false
  end

  def remains_on_board?(to_x:, to_y:)
    return true if to_x >= 1 && to_x <= 8 && to_y >= 1 && to_y <= 8
    false
  end

  def move_result(to_x:, to_y:)
    # Valid move: destination square is open
    return 'success' if target_piece(to_x: to_x, to_y: to_y).nil?

    # Valid move with enemy piece captured at destination
    if type != 'pawn' && !target_piece(to_x: to_x, to_y: to_y).nil? && !target_piece(to_x: to_x, to_y: to_y).pieces_turn?
      return 'kill'
    end

    # Invalid move: teammate piece is at destination
    return 'failed' if !target_piece(to_x: to_x, to_y: to_y).nil? && target_piece(to_x: to_x, to_y: to_y).pieces_turn?
  end

  ### private

  def pieces_turn?
    return true if color == game_of_piece.current_color
    false
  end

  def game_of_piece
    Game.find(game_id)
  end

  def target_piece(to_x:, to_y:)
    Piece.find_by(x_position: to_x, y_position: to_y, game_id: game_id, active: true)
  end

  def kill
    update(active: false)
  end

  # I need to figure out how to create a possible moves array for each color
# either by adding color to kings team (kings_team(color)) or by focusing on 
# the possible moves array.
  def kings_team
    Piece.where(color: color, game_id: game_id, active: true) 
  end

  def possible_moves
    possible_moves = []
      # initialize an 8x8 array of coordinates 1-8
    coords = Array.new(8) { [*1..8] }
    coords.each_with_index do |i, j|
      i.each do |t|
        # t is the x, i[j] is the y
        kings_team.each do |test_piece|
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

  def black_king
    Piece.find_by(type: 'King', color: 'black')
  end

  def white_king
    Piece.find_by(type: 'King', color: 'white')
  end

  def coord_builder(piece)
    coords = []
    coords << piece.x_position
    coords << piece.y_position
    coords
  end 

  def black_king_coords
    coord_builder(black_king) 
  end

  def white_king_coords
    coord_builder(white_king) 
  end

  def black_king_check
    bx =black_king_coords[0]
    by =black_king_coords[1]
    is_check = possible_moves.find_all { |kng| kng[1] == bx && kng[2] == by }
    unless is_check == nil return true
  end

  def white_king_check
    wx =white_king_coords[0]
    wy =white_king_coords[1]
    is_check = possible_moves.find_all { |foo| kng[1] == bx && kng[2] == by }
    unless is_check == nil return true
  end
    # May need to be a separate method: Only move allowed is one that gets out of check if 
    # above test returns true.
end
