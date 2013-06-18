require 'spec_helper'

feature 'Client factory requests' do
  let(:config) { FactoryGirl::RemoteApi.configuration }

  scenario 'create a user model from a remote factory' do
    stub_with_real_response('/user?')
    user = FactoryGirl::RemoteApi.create(:user)
    expect(User.count).to eq(1)
    expect(user.id).to_not be_nil
  end

  scenario 'create a user model from a remote factory with specific attributes' do
    stub_with_real_response('/user?user%5Bfirst_name%5D=James')
    user = FactoryGirl::RemoteApi.create(:user, first_name: 'James')
    expect(User.count).to eq(1)
    expect(user.id).to_not be_nil
    expect(user.first_name).to eq('James')
  end

  scenario 'create user model with specific attributes from a child factory' do
    stub_with_real_response('/authenticated_user?authenticated_user%5Bfirst_name%5D=James&authenticated_user%5Bparent_factory%5D=user')
    user = FactoryGirl::RemoteApi.create(:authenticated_user, first_name: 'James', parent_factory: 'user')
    expect(User.count).to eq(1)
    expect(user.id).to_not be_nil
    expect(user.first_name).to eq('James')
  end

  scenario 'build a user model from a remote factory' do
    stub_with_real_response('/build/user?')
    user = FactoryGirl::RemoteApi.build(:user)
    expect(User.count).to eq(0)
    expect(user.id).to be_nil
  end

  scenario 'build a user model from a remote factory with specific attributes' do
    stub_with_real_response('/build/user?user%5Bfirst_name%5D=James')
    user = FactoryGirl::RemoteApi.build(:user, first_name: 'James')
    expect(User.count).to eq(0)
    expect(user.id).to be_nil
    expect(user.first_name).to eq('James')
  end

  scenario 'attributes for a user model from a remote factory' do
    stub_with_real_response('/attributes_for/user?')
    user_attributes = FactoryGirl::RemoteApi.attributes_for(:user)
    expect(User.count).to eq(0)
    expect(user_attributes[:id]).to be_nil
  end

  scenario 'attributes for a user model from a remote factory with specific attributes' do
    stub_with_real_response('/attributes_for/user?user%5Bfirst_name%5D=James')
    user_attributes = FactoryGirl::RemoteApi.attributes_for(:user, first_name: 'James')
    expect(User.count).to eq(0)
    expect(user_attributes[:id]).to be_nil
    expect(user_attributes['first_name']).to eq('James')
    expect(user_attributes[:first_name]).to eq('James')
  end
end
