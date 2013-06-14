require 'spec_helper'

feature 'Create factory model' do
  scenario 'create user model via get' do
    expect {
      visit '/factories/user'
    }.to change { User.count }.from(0).to(1)
    expect(page.body).to eq(User.first.to_json)
  end

  scenario 'create user model with specific attributes' do
    expect {
      visit '/factories/user?user[first_name]=James'
    }.to change { User.count }.from(0).to(1)
    expect(JSON.parse(page.body)['first_name']).to eq('James')
  end

  scenario 'list attributes for a user without persisting it' do
    visit '/factories/attributes_for/user?user[first_name]=James'
    expect(JSON.parse(page.body)['first_name']).to eq('James')
    expect(User.count).to eq(0)
  end
end
