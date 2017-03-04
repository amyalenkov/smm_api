class LoadData

  def self.load_auth_url
    vk_auth_url = 'https://oauth.vk.com/authorize'
    client_id = '5087625'
    client_secret = 'swhRTZu4kZEu0pupb6lK'
    display = 'page'
    redirect_uri = 'http://127.0.0.1:9292/vk/auth/save_access_token'
    response_type = 'code'
    v = '5.62'
    AuthParam.create name: 'vk_auth_url', value: vk_auth_url
    AuthParam.create name: 'client_id', value: client_id
    AuthParam.create name: 'display', value: display
    AuthParam.create name: 'redirect_uri', value: redirect_uri
    AuthParam.create name: 'response_type', value: response_type
    AuthParam.create name: 'v', value: v
    AuthParam.create name: 'client_secret', value: client_secret
    vk_auth_url + '?client_id=' + client_id + '&display=' + display + '&redirect_uri=' + redirect_uri +
        '&response_type=' + response_type + '&v=' + v
  end

  def self.load_access_token(user_id, access_token)
    AccessToken.create user_id: user_id, access_token: access_token
  end
end