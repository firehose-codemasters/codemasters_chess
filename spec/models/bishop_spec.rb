require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe '#create' do
    it 'creates a bishop in the database' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.type == 'Bishop').to eq(true)
    end
  end

  describe '#valid_move?' do
    # Bishop Factory builds it at (5,5)
    it 'returns true if the move is diagonal up-right from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 7, to_y: 7)).to eq(true)
    end

    it 'returns true if the move is diagonal down-right from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 7, to_y: 3)).to eq(true)
    end

    it 'returns true if the move is diagonal up-left from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 2, to_y: 8)).to eq(true)
    end

    it 'returns true if the move is diagonal down-left from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 2, to_y: 2)).to eq(true)
    end

    it 'returns false if the move is horizontal from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 3, to_y: 5)).to eq(false)
    end

    it 'returns false if the move is vertical from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 5, to_y: 6)).to eq(false)
    end

    it 'returns false if the move is not horiz, diag, or vert from the bishop' do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(to_x: 1, to_y: 2)).to eq(false)
    end
  end
end
