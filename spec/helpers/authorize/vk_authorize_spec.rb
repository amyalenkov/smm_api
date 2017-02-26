require 'spec_helper'

context 'auth vk' do

  it 'check vk url' do
    vk_auth_url = 'https://url'
    client_id = '123'
    display = 'sdf'
    redirect_uri = 'https://url2/234/'
    response_type = '1'
    v = '5.34'
    AuthParam.create name: 'vk_auth_url', value: vk_auth_url
    AuthParam.create name: 'client_id', value: client_id
    AuthParam.create name: 'display', value: display
    AuthParam.create name: 'redirect_uri', value: redirect_uri
    AuthParam.create name: 'response_type', value: response_type
    AuthParam.create name: 'v', value: v
    expected_url = vk_auth_url + '?client_id=' + client_id + '&display=' + display + '&redirect_uri=' + redirect_uri +
        '&response_type=' + response_type + '&v=' + v
    expect(VkAuthorize.get_auth_url).to eq expected_url
  end

  it 'check access token' do
    user_id = 123
    access_token = '456'
    AccessToken.create user_id: user_id, access_token: access_token
    actual_access_token = VkAuthorize.get_access_token_by_user_id(user_id)['access_token']
    expect(actual_access_token).to eq access_token
  end

end