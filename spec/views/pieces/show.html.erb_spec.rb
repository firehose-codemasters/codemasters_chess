require 'rails_helper'

RSpec.describe 'pieces/show', type: :view do
  before do
    @piece = assign(:piece, Piece.create!(
      color: 'Color',
      active: false,
      x_position: 2,
      y_position: 3,
      type: 'Type',
      game: nil
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
  end
end
