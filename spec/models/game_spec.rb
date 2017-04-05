require 'rails_helper'

describe Game, type: :model do
  describe '.create' do
    let(:game) { FactoryGirl.create :game }

    context 'starting pieces' do
      it 'has the right number of pieces' do
        expect(game.pieces.size).to eq 32
      end

      it 'has the right number of white pieces' do
        expect(game.pieces.white.size).to eq 16
      end

      it 'has the right number of black pieces' do
        expect(game.pieces.black.size).to eq 16
      end
    end
  end
end
