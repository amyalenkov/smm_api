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

  def self.create_analyse_group
    group_id = rand
    start_time = DateTime.now
    finish_time = DateTime.now.next_month
    data = '{"xz": "some data"}'
    record = AnalyseGroup.create! group_id: group_id, start_time: start_time, finish_time: finish_time,
                                  data: data
    record
  end

  require 'bcrypt'
  def self.create_user(email, password)
    password_hash = BCrypt::Password.create(password)
    user = User.new(email: email, password_hash: password_hash)
    user.save!
  end
end