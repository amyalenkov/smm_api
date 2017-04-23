require 'spec_helper'

describe 'check token helper' do

  it 'should create token' do
    email = 'em@2m.com'
    password = 'password'
    LoadData.create_user email, password
    token = TokenHelper.create_token email, password
    puts token
    expect(token).to be
  end
end