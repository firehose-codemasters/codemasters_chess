# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before do
    @user = assign(:user, FactoryGirl.create(:user))
    render
  end

  it 'renders name attribute in <p>' do
    expect(rendered).to match(/Name/)
  end

  it 'renders email attribute in <p>' do
    expect(rendered).to match(/Email/)
  end
end
