require 'rails_helper'

RSpec.describe Piece, type: :model do
  # Overall move checking, this method pulls together all the move validations
  describe '#move_tests' do
    it 'returns true if the move is not obstructed diagonally' do
      piece = FactoryGirl.create(:bishop)
      expect(piece.move_tests(to_x: 8, to_y: 8)).to eq(true)
    end

    it 'returns false if the move is obstructed diagonally' do
      moving_piece = FactoryGirl.create(:bishop)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6)
      expect(moving_piece.move_tests(to_x: 8, to_y: 8)).to eq(false)
    end

    it 'returns true if the move is not obstructed vertically' do
      piece = FactoryGirl.create(:rook)
      expect(piece.move_tests(to_x: 1, to_y: 6)).to eq(true)
    end

    it 'returns false if the move is obstructed vertically' do
      moving_piece = FactoryGirl.create(:rook)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 5)
      expect(moving_piece.move_tests(to_x: 1, to_y: 7)).to eq(false)
    end

    it 'returns true if the move not obstructed horizontally' do
      piece = FactoryGirl.create(:rook)
      expect(piece.move_tests(to_x: 3, to_y: 3)).to eq(true)
    end

    it 'returns false if the move is obstructed horizontally' do
      moving_piece = FactoryGirl.create(:rook)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 3)
      expect(moving_piece.move_tests(to_x: 3, to_y: 3)).to eq(false)
    end

    it 'returns true if the move is on the board' do
      piece = FactoryGirl.create(:queen)
      expect(piece.move_tests(to_x: 6, to_y: 4)).to eq(true)
    end

    it 'returns false if the move is off the board' do
      piece = FactoryGirl.create(:queen)
      expect(piece.move_tests(to_x: 60, to_y: 4)).to eq(false)
    end

    it 'returns true if a king move follows the king rules' do
      king = FactoryGirl.create(:king)
      expect(king.move_tests(to_x: 5, to_y: 5)).to eq(true)
    end

    it 'returns false if a king move does not follow the king rules' do
      king = FactoryGirl.create(:king)
      expect(king.move_tests(to_x: 6, to_y: 6)).to eq(false)
    end

    it 'returns true if a queen move follows the queen rules' do
      queen = FactoryGirl.create(:queen)
      expect(queen.move_tests(to_x: 6, to_y: 6)).to eq(true)
    end

    it 'returns false if a queen move does not follow the queen rules' do
      queen = FactoryGirl.create(:queen)
      expect(queen.move_tests(to_x: 8, to_y: 5)).to eq(false)
    end

    it 'returns true if a knight move follows the knight rules' do
      knight = FactoryGirl.create(:knight)
      expect(knight.move_tests(to_x: 6, to_y: 5)).to eq(true)
    end

    it 'returns false if a knight move does not follow the knight rules' do
      knight = FactoryGirl.create(:knight)
      expect(knight.move_tests(to_x: 5, to_y: 5)).to eq(false)
    end

    it 'returns true if a bishop move follows the bishop rules' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.move_tests(to_x: 8, to_y: 8)).to eq(true)
    end

    it 'returns false if a bishop move does not follow the bishop rules' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.move_tests(to_x: 8, to_y: 5)).to eq(false)
    end

    it 'returns true if a rook move follows the rook rules' do
      rook = FactoryGirl.create(:rook)
      expect(rook.move_tests(to_x: 1, to_y: 7)).to eq(true)
    end

    it 'returns false if a rook move does not follow the rook rules' do
      rook = FactoryGirl.create(:rook)
      expect(rook.move_tests(to_x: 2, to_y: 7)).to eq(false)
    end

    it 'returns true if a pawn move follows the pawn rules' do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.move_tests(to_x: 1, to_y: 3)).to eq(true)
    end

    it 'returns false if a pawn move does not follow the pawn rules' do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.move_tests(to_x: 1, to_y: 7)).to eq(false)
    end

    it 'returns true if a capture is made' do
      white_queen = FactoryGirl.create(:queen)
      FactoryGirl.create(:bishop, game_id: white_queen.game_id)
      expect(white_queen.move_tests(to_x: 5, to_y: 5)).to eq(true)
    end

    it 'returns false if trying to capture a teammate' do
      white_queen = FactoryGirl.create(:queen)
      FactoryGirl.create(:bishop, color: 'white', game_id: white_queen.game_id)
      expect(white_queen.move_tests(to_x: 5, to_y: 5)).to eq(false)
    end

    it 'returns false if a pawn tries to capture a piece one square in front of it' do
      moving_piece = FactoryGirl.create(:piece, type: 'pawn', color: 'white', x_position: 4, y_position: 4)
      FactoryGirl.create(:piece, color: 'black', x_position: 4, y_position: 5, game_id: moving_piece.game_id)
      expect(moving_piece.move_tests(to_x: 4, to_y: 5)).to eq(false)
    end
  end

  # Diagonal obstruction logic
  describe '#obstructed_diagonally?' do
    it 'returns true if the move is obstructed in the up-right direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6)
      expect(moving_piece.obstructed_diagonally?(to_x: 8, to_y: 8)).to eq(true)
    end

    it 'returns true if the move is obstructed in the down-left direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2)
      expect(moving_piece.obstructed_diagonally?(to_x: 1, to_y: 1)).to eq(true)
    end

    it 'returns true if the move is obstructed in the up-left direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 6)
      expect(moving_piece.obstructed_diagonally?(to_x: 1, to_y: 7)).to eq(true)
    end

    it 'returns true if the move is obstructed in the down-right direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2)
      expect(moving_piece.obstructed_diagonally?(to_x: 7, to_y: 1)).to eq(true)
    end

    it 'returns false if the move is not obstructed' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      expect(moving_piece.obstructed_diagonally?(to_x: 8, to_y: 8)).to eq(false)
    end
  end

  # Vertical obstructions:
  describe '#obstructed_vertically?' do
    it 'returns true if the move is obstructed vertically going up the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 4) # Use _ for unused variable
      expect(moving_piece.obstructed_vertically?(to_y: 7)).to eq(true)
    end

    it 'returns true if the move is obstructed vertically going down the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 6)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 4) # Use _ for unused variable
      expect(moving_piece.obstructed_vertically?(to_y: 2)).to eq(true)
    end

    it 'returns false if the move is not obstructed vertically going up the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.obstructed_vertically?(to_y: 7)).to eq(false)
    end

    it 'returns false if the move is not obstructed vertically going down the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 8)
      expect(moving_piece.obstructed_vertically?(to_y: 2)).to eq(false)
    end
  end

  # Horizontal obstructions:
  describe '#obstructed_horizontally?' do
    it 'returns true if the move is obstructed horizontally going right on the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 3) # Use _ for unused variable
      expect(moving_piece.obstructed_horizontally?(to_x: 7)).to eq(true)
    end

    it 'returns true if the move is obstructed horizontally going left on the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 5, y_position: 6)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 3, y_position: 6) # Use _ for unused variable
      expect(moving_piece.obstructed_horizontally?(to_x: 2)).to eq(true)
    end

    it 'returns false if the move is not obstructed horizontally going right on the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.obstructed_horizontally?(to_x: 7)).to eq(false)
    end

    it 'returns false if the move is not obstructed horizontally going left on the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 8, y_position: 1)
      expect(moving_piece.obstructed_horizontally?(to_x: 2)).to eq(false)
    end
  end

  # Off board check:
  describe '#remains_on_board' do
    it 'returns true if the move is to a square on the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.remains_on_board?(to_x: 7, to_y: 3)).to eq(true)
    end

    it 'returns false if the moving piece has an x_position off the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.remains_on_board?(to_x: 11, to_y: 3)).to eq(false)
    end

    it 'returns false if the moving piece has a y_position off the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.remains_on_board?(to_x: 1, to_y: -1)).to eq(false)
    end

    it 'returns false if the moving piece has an x_position and a y_position off the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.remains_on_board?(to_x: 0, to_y: 13)).to eq(false)
    end
  end

  # Testing of move_result method for piece
  describe '#move_result' do
    it 'returns success if there is no piece (of either color) at to_x, to_y' do
      moving_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2)
      expect(moving_piece.move_result(to_x: 6, to_y: 2)).to eq('success')
    end

    it 'returns kill if there is an enemy ("target") piece at to_x, to_y' do
      moving_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2)
      _target_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2, color: 'black', game_id: moving_piece.game_id)
      expect(moving_piece.move_result(to_x: 6, to_y: 2)).to eq('kill')
    end

    it 'returns failed if there is a teammate (same-color-as-moving) piece at to_x, to_y' do
      moving_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2)
      _target_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2, game_id: moving_piece.game_id)
      expect(moving_piece.move_result(to_x: 6, to_y: 2)).to eq('failed')
    end
  end

  # # Testing of pieces_turn? method for piece
  # describe 'pieces_turn?' do
  #   it 'returns true if piece has the same color as the current_color in a particular game' do
  #     game = FactoryGirl.create(:game)
  #     moving_piece = FactoryGirl.create(:piece, color: 'white', game_id: game.id)
  #     expect(moving_piece.pieces_turn?).to eq(true)
  #   end

  #   it 'returns false if piece has a different color as the current_color in a particular game' do
  #     game = FactoryGirl.create(:game)
  #     moving_piece = FactoryGirl.create(:piece, color: 'black', game_id: game.id)
  #     expect(moving_piece.pieces_turn?).to eq(false)
  #   end
  # end

  # Testing of did_it_move? method for piece
  describe 'did_it_move?' do
    it 'returns true if moved piece has a different y coordinate than when first moved' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.did_it_move?(to_x: 1, to_y: 4)).to eq(true)
    end

    it 'returns true if moved piece has a different x coordinate than when first moved' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.did_it_move?(to_x: 2, to_y: 3)).to eq(true)
    end

    it 'returns true if moved piece has different x & y coordinates than when first moved' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.did_it_move?(to_x: 3, to_y: 5)).to eq(true)
    end

    it 'returns false if moved piece has the same coordinates as when first moved' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.did_it_move?(to_x: 1, to_y: 3)).to eq(false)
    end
  end

  # Testing of game_ofpiece method for piece
  describe 'game_of_piece' do
    it 'returns the game that the piece belongs to' do
      piece = FactoryGirl.create(:queen, color: 'white')
      expect(piece.game_of_piece).to eq(Game.find(piece.game_id))
    end
  end

  # Testing of kill method for piece
  describe 'kill' do
    it 'updates the attribute of the piece it is called on to active: false' do
      piece = FactoryGirl.create(:bishop)
      piece.kill
      piece.reload
      expect(piece.active).to eq(false)
    end
  end

  #   # test to see if I can grab x y coordinates of white king
  # describe 'white_king_coords' do
  #   it 'returns the x and y coordinates of the white king' do
  #     king = FactoryGirl.create(:king)
  #     expect(king.white_king_coords).to eq([4, 4])
  #   end
  # end

  # #test to see if wrong x y coordinates of white are detected
  # describe 'white_king_coords' do
  #   it 'returns the x and y coordinates of the white king' do
  #     king = FactoryGirl.create(:king)
  #     expect(king.white_king_coords).not_to eq([4, 5])
  #   end
  # end

  # #test to see if I can grab x y coordinates of king
  # describe 'black_king_coords' do
  #   it 'returns the x and y coordinates of the black king' do
  #     king = FactoryGirl.create(:king, color: 'black', x_position: 3, y_position: 3)
  #     expect(king.black_king_coords).to eq([3, 3])
  #   end
  # end

  # #test to see if wrong x y coordinates of black king are detected
  # describe 'black_king_coords' do
  #   it 'returns the x and y coordinates of the black king' do
  #     king = FactoryGirl.create(:king, color: 'black', x_position: 3, y_position: 3)
  #     expect(king.black_king_coords).not_to eq([4, 4])
  #   end
  # end

  # test to see if I can grab x y coordinates of offensive king
  describe 'king_coords' do
    it 'returns the x and y coordinates of the offensive king' do
      game = FactoryGirl.create(:game)
      game.next_turn
      king = FactoryGirl.create(:king, color: 'black', x_position: 3, y_position: 3, game_id: game.id)
      expect(king.king_coords(game.current_color)).to eq([3, 3])
    end

    it 'rejects the wrong x and y coordinates of the offensive king' do
      game = FactoryGirl.create(:game)
      game.next_turn
      king = FactoryGirl.create(:king, color: 'black', x_position: 3, y_position: 3, game_id: game.id)
      expect(king.king_coords(game.current_color)).not_to eq([4, 5])
    end

    it 'returns the x and y coordinates of the defensive king' do
      game = FactoryGirl.create(:game)
      game.next_turn
      king = FactoryGirl.create(:king, color: 'white', x_position: 3, y_position: 3, game_id: game.id)
      expect(king.king_coords(game.resting_color)).to eq([3, 3])
    end

    it 'rejects the wrong x and y coordinates of the defensive king' do
      game = FactoryGirl.create(:game)
      game.next_turn
      king = FactoryGirl.create(:king, color: 'white', x_position: 3, y_position: 3, game_id: game.id)
      expect(king.king_coords(game.resting_color)).not_to eq([4, 4])
    end
  end

  describe 'possible_moves' do
    it 'returns all possible moves of the called sides pieces' do
      game = FactoryGirl.create(:game)
      # king = FactoryGirl.create(:king, color: 'white', x_position: 8, y_position: 4, game_id: game.id)
      pawn = FactoryGirl.create(:pawn, color: 'white', x_position: 7, y_position: 5, game_id: game.id)
      this_side = pawn.offense
      expect(pawn.possible_moves(this_side)).to eq([[pawn.id, 7, 6]])
      # need to add in some more pieces and add a second test for defense
    end
  end

  # describe 'offensive_king_check' do
  #   it 'returns true if the offensive king is in check'
  #     game = FactoryGirl.create(:game)
  #     king = FactoryGirl.create(:king, color: 'white', x_position: 8, y_position: 4, game_id: game.id)
  #     pawn = FactoryGirl.create(:pawn, color: 'black', x_position: 7, y_position: 5, game_id: game.id)
  #     this_side = pawn.offense
  #     expect(pawn.possible_moves(this_side)).to eq([[pawn.id, 7,6]])
  #     # need to add in some more pieces and add a second test for defense
  #   end
  # end
end
