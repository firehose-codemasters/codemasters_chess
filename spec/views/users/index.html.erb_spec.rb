require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before { assign(:users, [create(:user), create(:user)]) }

  it 'renders a list of users' do
    render
  end
end
