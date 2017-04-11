require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#obstructed_diagonally?' do
    it 'returns true if the move is obstructed' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      _blocking_piece = FactoryGirl.create(:piece, x_position: 5, y_position: 5)
      expect(moving_piece.obstructed_diagonally?(to_x: 5, to_y: 5)).to eq(true)
    end

    it 'returns false if the move is not obstructed' do
      moving_piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4)
      expect(moving_piece.obstructed_diagonally?(to_x: 5, to_y: 5)).to eq(false)
    end
  end
end
