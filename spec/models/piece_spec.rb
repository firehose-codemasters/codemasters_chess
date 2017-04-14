require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#obstructed_diagonally?' do
    it 'returns true if the move is obstructed in the up-right direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 6)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 8, to_y: 8)).to eq(true)
    end

    it 'returns true if the move is obstructed in the down-left direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 2)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 1, to_y: 1)).to eq(true)
    end

    it 'returns true if the move is obstructed in the up-left direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 2, y_position: 6)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 1, to_y: 7)).to eq(true)
    end

    it 'returns true if the move is obstructed in the down-right direction' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 6, y_position: 2)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 7, to_y: 1)).to eq(true)
    end

    it 'returns false if the move is not obstructed' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      expect(moving_piece.obstructed_diagonally?(from_x: 4, from_y: 4, to_x: 8, to_y: 8)).to eq(false)
    end
  end

  # Vertical obstructions:
  describe '#obstructed_vertically?' do
    it 'returns true if the move is obstructed vertically going up the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 4) # Use _ for unused variable
      expect(moving_piece.obstructed_vertically?(current_y: 3, target_y: 7)).to eq(true)
    end

    it 'returns true if the move is obstructed vertically going down the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 6)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 4) # Use _ for unused variable
      expect(moving_piece.obstructed_vertically?(current_y: 6, target_y: 2)).to eq(true)
    end

    it 'returns false if the move is not obstructed vertically going up the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 3)
      expect(moving_piece.obstructed_vertically?(current_y: 3, target_y: 7)).to eq(false)
    end

    it 'returns false if the move is not obstructed vertically going down the board' do
      moving_piece = FactoryGirl.create(:piece, x_position: 1, y_position: 8)
      expect(moving_piece.obstructed_vertically?(current_y: 8, target_y: 2)).to eq(false)
    end
  end
end
