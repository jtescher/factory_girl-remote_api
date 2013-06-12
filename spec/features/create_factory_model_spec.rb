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

  scenario 'list attributes for a user without persisting it' do
    visit '/factories/attributes_for/user?user[first_name]=James'
    expect(JSON.parse(page.body)['first_name']).to eq('James')
    expect(User.count).to eq(0)
  end
end
