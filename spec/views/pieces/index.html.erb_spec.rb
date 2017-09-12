require 'rails_helper'

RSpec.describe 'pieces/index', type: :view do
  before { assign(:pieces, [create(:piece), create(:piece)]) }

  it 'renders a list of pieces' do
    render
    assert_select 'tr>td', text: 'white'.to_s, count: 2
    assert_select 'tr>td', text: 'true'.to_s, count: 2
    assert_select 'tr>td', text: '1'.to_s, count: 4
    assert_select 'tr>td', text: ''.to_s, count: 2
  end
end
