require 'rails_helper'

RSpec.describe 'pieces/index', type: :view do
  before do
    assign(:pieces, [
      Piece.create!(
        color: 'Color',
        active: false,
        x_position: 2,
        y_position: 3,
        # Type needs to be implemented when first piece is created:
        # type: 'Type',
        game: nil
      ),
      Piece.create!(
        color: 'Color',
        active: false,
        x_position: 2,
        y_position: 3,
        # Type needs to be implemented when first piece is created:
        # type: 'Type',
        game: nil
      )
    ])
  end

  it 'renders a list of pieces' do
    render
    assert_select 'tr>td', text: 'Color'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 'Type'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
