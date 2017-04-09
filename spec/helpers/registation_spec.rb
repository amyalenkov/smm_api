require 'spec_helper'

describe 'registration' do

  it 'check email' do
    email = 'new@email.com'
    LoadData.create_user email, 'password'
    expect(Registration.email_is_present?(email)).to eq true
    expect(Registration.email_is_present?('new1111@email.com')).to eq false
  end

  it 'create user' do
    email = 'new@email.com'
    user = Registration.create_user email, 'password'
    expect(user.email).to eq email
    expect(user.id).to be
  end
end