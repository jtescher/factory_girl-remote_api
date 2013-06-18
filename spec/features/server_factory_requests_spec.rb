require 'spec_helper'

feature 'Server factory requests' do
  scenario 'create a user model' do
    expect {
      visit '/factories/user'
    }.to change { User.count }.from(0).to(1)
    expect(page.body).to eq(User.first.to_json)
  end

  scenario 'create a user model with specific attributes' do
    expect {
      visit '/factories/user?user[first_name]=James'
    }.to change { User.count }.from(0).to(1)
    expect(JSON.parse(page.body)['first_name']).to eq('James')
  end

  scenario 'create user model with specific attributes from a child factory' do
    expect {
      visit '/factories/authenticated_user?authenticated_user[first_name]=James&authenticated_user[parent_factory]=user'
    }.to change { User.count }.from(0).to(1)
    expect(JSON.parse(page.body)['first_name']).to eq('James')
  end

  scenario 'build a user model' do
    visit '/factories/build/user'
    expect(JSON.parse(page.body)['id']).to be_nil
    expect(User.count).to eq(0)
  end

  scenario 'build a user model with specific attributes' do
    visit '/factories/build/user?user[first_name]=James'
    expect(JSON.parse(page.body)['id']).to be_nil
    expect(JSON.parse(page.body)['first_name']).to eq('James')
    expect(User.count).to eq(0)
  end

  scenario 'get attributes for a user' do
    visit '/factories/attributes_for/user'
    expect(JSON.parse(page.body)['id']).to be_nil
    expect(User.count).to eq(0)
  end

  scenario 'get attributes for a user with specific attributes' do
    visit '/factories/attributes_for/user?user[first_name]=James'
    expect(JSON.parse(page.body)['id']).to be_nil
    expect(JSON.parse(page.body)['first_name']).to eq('James')
    expect(User.count).to eq(0)
  end
end
