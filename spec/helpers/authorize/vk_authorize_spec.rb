require 'spec_helper'

context 'auth vk' do

  it 'check vk url' do
    expected_url = LoadData.load_auth_url
    expect(VkAuthorize.get_auth_url).to eq expected_url
  end

  it 'check access token' do
    user_id = 123
    access_token = '456'
    LoadData.load_access_token user_id, access_token
    actual_access_token = VkAuthorize.get_access_token_by_user_id(user_id)['access_token']
    expect(actual_access_token).to eq access_token
  end

end