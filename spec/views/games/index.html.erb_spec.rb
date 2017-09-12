require 'rails_helper'

RSpec.describe 'games/index', type: :view do
  before { assign(:games, [create(:game), create(:game)]) }

  it 'renders a list of games' do
    render
    assert_select 'tr>td', text: 'Chess'.to_s, count: 2
    assert_select 'tr>td', text: 'in_progress'.to_s, count: 2
  end
end
