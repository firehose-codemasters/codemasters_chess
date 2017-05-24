require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe '#create' do
    it 'creates a pawn in the database' do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.type == 'Pawn').to eq(true)
    end
  end

  describe '#valid_move?' do
    it 'returns true if the white pawn successfully has a normal move' do
      pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 3, color: 'white')
      expect(pawn.valid_move?(to_x: 2, to_y: 4)).to eq(true)
    end

    it 'returns true if the black pawn successfully has a normal move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 6, color: 'black')
      expect(pawn.valid_move?(to_x: 4, to_y: 5)).to eq(true)
    end

    it 'returns true if the white pawn moves successfully one space on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2, color: 'white')
      expect(pawn.valid_move?(to_x: 1, to_y: 3)).to eq(true)
    end

    it 'returns true if the white pawn moves successfully two spaces on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2, color: 'white')
      expect(pawn.valid_move?(to_x: 1, to_y: 4)).to eq(true)
    end

    it 'returns true if the black pawn moves successfully one space on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 7, color: 'black')
      expect(pawn.valid_move?(to_x: 1, to_y: 6)).to eq(true)
    end

    it 'returns true if the black pawn moves successfully two spaces on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 7, color: 'black')
      expect(pawn.valid_move?(to_x: 1, to_y: 5)).to eq(true)
    end

    it 'returns true if the white pawn moves successfully diagonally forward to the left' do
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 3, color: 'white')
      FactoryGirl.create(:rook, x_position: 4, y_position: 4, color: 'black')
      expect(pawn.valid_move?(to_x: 4, to_y: 4)).to eq(true)
    end

    it 'returns true if the white pawn moves successfully diagonally forward to the right' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'white')
      FactoryGirl.create(:rook, x_position: 8, y_position: 6, color: 'black')
      expect(pawn.valid_move?(to_x: 8, to_y: 6)).to eq(true)
    end

    it 'returns true if the black piece moves successfully diagonally forward to the left' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'black', game_id: game.id)
      FactoryGirl.create(:rook, x_position: 6, y_position: 4, color: 'white', game_id: game.id)
      game.next_turn
      expect(pawn.valid_move?(to_x: 6, to_y: 4)).to eq(true)
    end

    it 'returns true if the black piece moves successfully diagonally forward to the right on a capture' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'black', game_id: game.id)
      FactoryGirl.create(:rook, x_position: 8, y_position: 4, color: 'white', game_id: game.id)
      game.next_turn
      expect(pawn.valid_move?(to_x: 8, to_y: 4)).to eq(true)
    end

    it 'returns false if the white pawn moves backwards' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'white')
      expect(pawn.valid_move?(to_x: 7, to_y: 4)).to eq(false)
    end

    it 'returns false if the black pawn moves backwards' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'black')
      expect(pawn.valid_move?(to_x: 7, to_y: 6)).to eq(false)
    end

    it 'returns false if the black pawn moves sideways' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5, color: 'black')
      expect(pawn.valid_move?(to_x: 3, to_y: 5)).to eq(false)
    end
    #### THESE ARE NOT VALID PAWN MOVES ####
    # it 'returns true if the white pawns first move is diagonal up and to the right' do
    #   pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 2, color: 'white')
    #   expect(pawn.valid_move?(to_x: 8, to_y: 3)).to eq(true)
    # end

    # it 'returns true if the black pawns first move is diagonal down and to the right' do
    #   pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 7, color: 'black')
    #   expect(pawn.valid_move?(to_x: 8, to_y: 6)).to eq(true)
    # end
  end
end
