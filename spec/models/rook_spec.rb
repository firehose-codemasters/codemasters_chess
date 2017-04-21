require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe '#create' do
    it 'creates a rook in the database' do
      rook = FactoryGirl.create(:rook)
      expect(rook.type == 'Rook').to eq(true)
    end
  end

  describe '#piece_rules?' do
    it 'returns true if the move conforms to the allowable horizontal pathway of a rook piece' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 3)
      expect(rook.piece_rules?(to_x: 7, to_y: 3)).to eq(true)
    end  

    it 'returns true if the move conforms to the allowable vertical pathway of a rook piece' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 3)
      expect(rook.piece_rules?(to_x: 1, to_y: 5)).to eq(true)
    end

    it 'returns false if the rook piece is moved diagonally' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 3)
      expect(rook.piece_rules?(to_x: 3, to_y: 5)).to eq(false)
    end

    it 'returns false if the rook piece is moved like a knight' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 3)
      expect(rook.piece_rules?(to_x: 2, to_y: 5)).to eq(false)
    end
  end
end
