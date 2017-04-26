require 'rails_helper'

RSpec.describe King, type: :model do
  describe '#create' do
    it 'creates a king in the database' do
      king = FactoryGirl.create(:king)
      expect(king.type == 'King').to eq(true)
    end
  end

  describe '#valid_move?' do
    it 'returns true if the move is diagonal up-right one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 5, to_y: 5)).to eq(true)
    end

    it 'returns true if the move is diagonal down-right one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 5, to_y: 3)).to eq(true)
    end

    it 'returns true if the move is diagonal up-left one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 3, to_y: 5)).to eq(true)
    end

    it 'returns true if the move is diagonal down-left one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 3, to_y: 3)).to eq(true)
    end

    it 'returns true if the move is vertical up one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 4, to_y: 5)).to eq(true)
    end

    it 'returns true if the move is vertical down one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 4, to_y: 3)).to eq(true)
    end

    it 'returns true if the move is horizontal left one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 3, to_y: 4)).to eq(true)
    end

    it 'returns true if the move is horizontal right one square' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 5, to_y: 4)).to eq(true)
    end

    it 'returns false if the move is not one square horiz, vert, or diag' do
      king = FactoryGirl.create(:king)
      expect(king.valid_move?(to_x: 1, to_y: 1)).to eq('King may move only one square per turn! Please try again.')
    end
  end
end
