require 'rails_helper'

RSpec.describe 'games/show', type: :view do
  before do
    @game = assign(:game, FactoryGirl.create(:game))
    render
  end

  it 'renders name attribute in <p>' do
    expect(rendered).to match(/Name/)
  end

  it 'renders result attribute in <p>' do
    expect(rendered).to match(/Result/)
  end

  it 'renders white_player association in <p>' do
    expect(rendered).to match(/White/)
  end

  it 'renders black_player association in <p>' do
    expect(rendered).to match(/Black/)
  end
end
