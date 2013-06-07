require 'spec_helper'

feature 'Create factory model' do
  scenario 'create user model via get' do
    visit '/factories/user'
    expect(page.body).to eq(User.first.to_json)
  end
end
