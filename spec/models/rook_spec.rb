require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe '#create' do
    it 'creates a rook in the database' do
      rook = FactoryGirl.create(:rook)
      expect(rook.type == 'Rook').to eq(true)
    end
  end

  describe '#piece_rules?' do
    it 'returns true if the rook successfully moves to the right along a horizontal pathway' do
      rook = FactoryGirl.create(:rook)
      expect(rook.piece_rules?(to_x: 7, to_y: 3)).to eq(true)
    end

    it 'returns true if the rook successfully moves to the left along a horizontal pathway' do
      rook = FactoryGirl.create(:rook, x_position: 7, y_position: 3)
      expect(rook.piece_rules?(to_x: 1, to_y: 3)).to eq(true)
    end

    it 'returns true if the rook successfully moves up along a vertical pathway' do
      rook = FactoryGirl.create(:rook)
      expect(rook.piece_rules?(to_x: 1, to_y: 5)).to eq(true)
    end

    it 'returns true if the rook successfully moves down along a vertical pathway' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 5)
      expect(rook.piece_rules?(to_x: 1, to_y: 1)).to eq(true)
    end

    it 'returns false if the rook piece is moved diagonally in an upward direction' do
      rook = FactoryGirl.create(:rook)
      expect(rook.piece_rules?(to_x: 3, to_y: 5)).to eq(false)
    end

    it 'returns false if the rook piece is moved diagonally in a downward direction' do
      rook = FactoryGirl.create(:rook, x_position: 6, y_position: 8)
      expect(rook.piece_rules?(to_x: 3, to_y: 5)).to eq(false)
    end

    it 'returns false if the rook piece is moved like a knight' do
      rook = FactoryGirl.create(:rook)
      expect(rook.piece_rules?(to_x: 2, to_y: 5)).to eq(false)
    end
  end
end
