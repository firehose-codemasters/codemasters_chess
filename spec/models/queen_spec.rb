require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe '#create' do
    it 'creates a queen in the database' do
      queen = FactoryGirl.create(:queen)
      expect(queen.type == 'Queen').to eq(true)
    end
  end
end
