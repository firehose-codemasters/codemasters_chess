require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe '#create' do
    it 'creates a queen in the database' do
      queen = FactoryGirl.create(:queen)
      expect(queen.type == 'Queen').to eq(true)
    end
  end

  describe '#valid_queen_move?' do
    it 'returns true if the move is diagonal up-right from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 7, to_y: 7)).to eq(true)
    end

    it 'returns true if the move is diagonal down-right from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 7, to_y: 1)).to eq(true)
    end

    it 'returns true if the move is diagonal up-left from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 2, to_y: 6)).to eq(true)
    end

    it 'returns true if the move is diagonal down-left from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 2, to_y: 2)).to eq(true)
    end

    it 'returns true if the move is vertical up from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 4, to_y: 7)).to eq(true)
    end

    it 'returns true if the move is vertical down from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 4, to_y: 1)).to eq(true)
    end

    it 'returns true if the move is horizontal left from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 1, to_y: 4)).to eq(true)
    end

    it 'returns true if the move is horizontal right from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 7, to_y: 4)).to eq(true)
    end

    it 'returns false if the move is not horiz, vert, or diag from the queen' do
      queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)
      expect(queen.valid_queen_move?(to_x: 5, to_y: 7)).to eq(false)
    end
  end
end
