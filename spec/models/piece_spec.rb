require 'rails_helper'

RSpec.describe Piece, type: :model do
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

  # Testing of is_pieces_turn? method for piece
  describe 'pieces_turn?' do
    it 'returns true if piece has the same color as the current_color in a particular game' do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, color: 'white', game_id: game.id)
      expect(moving_piece.pieces_turn?).to eq(true)
    end

    it 'returns false if piece has a different color as the current_color in a particular game' do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, color: 'black', game_id: game.id)
      expect(moving_piece.pieces_turn?).to eq(false)
    end
  end
end
