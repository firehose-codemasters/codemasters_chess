require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) { create :user }

  before { @user = assign(:user, user) }

  it 'renders the edit user form' do
    render
    assert_select 'form[action=?][method=?]', user_path(user), 'post'
  end
end
