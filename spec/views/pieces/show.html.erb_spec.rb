require 'rails_helper'

RSpec.describe 'pieces/show', type: :view do
  before do
    @piece = FactoryGirl.create(:piece)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/white/)
    expect(rendered).to match(/true/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
    # expect(rendered).to match(//)
  end
end
