require 'spec_helper'

feature 'Create remote API request' do
  let(:config) { FactoryGirlRails::RemoteApi.configuration }

  scenario 'create request for user model' do
    stub_with_real_response('/user?')
    user = FactoryGirlRails::RemoteApi.create(:user)
    expect(User.count).to eq(1)
    expect(user.id).to_not be_nil
  end

  scenario 'create request for user model with specific attributes' do
    stub_with_real_response('/user?user%5Bfirst_name%5D=James')
    user = FactoryGirlRails::RemoteApi.create(:user, first_name: 'James')
    expect(User.count).to eq(1)
    expect(user.id).to_not be_nil
    expect(user.first_name).to eq('James')
  end

  scenario 'create request for attributes of a user without persisting it' do
    stub_with_real_response('/attributes_for/user?user%5Bfirst_name%5D=James')
    user = FactoryGirlRails::RemoteApi.attributes_for(:user, first_name: 'James')
    expect(User.count).to eq(0)
    expect(user.first_name).to eq('James')
  end
end
