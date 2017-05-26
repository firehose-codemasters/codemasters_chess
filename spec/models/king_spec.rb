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
      expect(king.valid_move?(to_x: 1, to_y: 1)).to eq(false)
    end
  end

  describe '#kings_team' do
    it 'creates an array of all the pieces in the game of the same color as king' do
      king = FactoryGirl.create(:king, color: 'white')
      pawn1 = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'white')
      pawn2 = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'white')
      bishop = FactoryGirl.create(:bishop, game_id: king.game_id, color: 'black')
      expect(king.kings_team).to match_array [king, pawn1, pawn2]
    end

    it 'creates an array which does not contain pieces not belonging to the kings game' do
      king = FactoryGirl.create(:king, color: 'white')
      pawn1 = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'white')
      pawn2 = FactoryGirl.create(:pawn, color: 'white')
      expect(king.kings_team).to match_array [king, pawn1]
    end
    it 'creates an array which does not contain pieces of a different color' do
      king = FactoryGirl.create(:king, color: 'white')
      pawn1 = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'white')
      pawn2 = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'black')
      expect(king.kings_team).to match_array [king, pawn1]
    end
  end

  describe '#possible_moves' do
    it 'tests all possible moves for a piece on the kings team' do
      king = FactoryGirl.create(:king, color: 'white')
      pawn = FactoryGirl.create(:pawn, game_id: king.game_id, color: 'white')
      king.kings_team
      king.possible_moves
      binding.pry
    end
  end
end
