require 'spec_helper'

feature 'Create factory model' do
  scenario 'create user model via get' do
    visit '/factories/user'
    expect(page.body).to eq(User.first.to_json)
  end

  scenario 'create user model with specific attributes' do
    visit '/factories/user?user[first_name]=James'
    expect(JSON.parse(page.body)['first_name']).to eq('James')
  end
end
