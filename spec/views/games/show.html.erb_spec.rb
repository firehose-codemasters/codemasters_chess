require 'rails_helper'

RSpec.describe 'games/show', type: :view do
  before do
    @game = assign(:game, FactoryGirl.create(:game))
    @white_player = assign(:user, FactoryGirl.create(:user))
    @black_player = assign(:user, FactoryGirl.create(:user))
    render
  end

  it 'renders name attribute in <p>' do
    expect(rendered).to match('Chess')
  end

  it 'renders result attribute in <p>' do
    expect(rendered).to match('in_progress')
  end

  it 'renders white_player association in <p>' do
    expect(rendered).to match(@game.white_player.name)
  end

  it 'renders black_player association in <p>' do
    expect(rendered).to match(@game.black_player.name)
  end
end
