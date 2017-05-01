require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe '#create' do
    it 'creates a pawn in the database' do
      pawn = FactoryGirl.create(:pawn)
      expect(pawn.type == 'Pawn').to eq(true)
    end
  end

  describe '#valid_pawn_move?' do
    it 'returns true if the white pawn successfully has a normal move' do
      pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 3)
      expect(pawn.valid_pawn_move?(to_x: 2, to_y: 4)).to eq(true)
    end  

    it 'returns true if the black pawn successfully has a normal move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 6)
      expect(pawn.valid_pawn_move?(to_x: 4, to_y: 5)).to eq(true)
    end  

    it 'returns true if the white pawn moves successfully one piece on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2)
      expect(pawn.valid_pawn_move?(to_x: 1, to_y: 3)).to eq(true)
    end

    it 'returns true if the white pawn moves successfully two pieces on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2)
      expect(pawn.valid_pawn_move?(to_x: 1, to_y: 4)).to eq(true)
    end

    it 'returns true if the black pawn moves successfully one piece on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 7)
      expect(pawn.valid_pawn_move?(to_x: 1, to_y: 6)).to eq(true)
    end

    it 'returns true if the black pawn moves successfully two pieces on the first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 7)
      expect(pawn.valid_pawn_move?(to_x: 1, to_y: 5)).to eq(true)
    end

    it 'returns true if the white piece moves successfully diagonally forward to the left' do
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 3)
      expect(pawn.valid_pawn_move?(to_x: 4, to_y: 4)).to eq(true)
    end
    it 'returns true if the white piece moves successfully diagonlly forward to the right' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5)
      expect(pawn.valid_pawn_move?(to_x: 8, to_y: 6)).to eq(true)
    end
    it 'returns true if the black piece moves successfully diagonally forward to the left' do
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 6)
      expect(pawn.valid_pawn_move?(to_x: 4, to_y: 5)).to eq(true)
    end
    it 'returns true if the black piece moves successfully diagonlly forward to the right' do
      pawn = FactoryGirl.create(:pawn, x_position: 7, y_position: 5)
      expect(pawn.valid_pawn_move?(to_x: 8, to_y: 4)).to eq(true)
    end
  end
end
