require_relative '../../../app/helpers/vk_sender'

class VkAuthorize

  def self.get_auth_url
    all_params = AuthParam.all
    vk_auth_url = all_params.find { |item| item[:name] == 'vk_auth_url'}[:value]
    client_id = all_params.find { |item| item[:name] == 'client_id'}[:value]
    display = all_params.find { |item| item[:name] == 'display'}[:value]
    redirect_uri = all_params.find { |item| item[:name] == 'redirect_uri'}[:value]
    response_type = all_params.find { |item| item[:name] == 'response_type'}[:value]
    v = all_params.find { |item| item[:name] == 'v'}[:value]
    vk_auth_url + '?client_id=' + client_id + '&display=' + display + '&redirect_uri=' + redirect_uri +
        '&response_type=' + response_type + '&v=' + v
  end

  def self.send_code_and_save_token(code)
    response = get_access_token code
    access_token = response['access_token']
    user_id = response['user_id']
    save_access_token access_token, user_id
  end

  def self.get_access_token_by_user_id(user_id)
    AccessToken.find_by user_id: user_id
  end

  private

  def self.save_access_token(access_token, user_id)
    AccessToken.create access_token: access_token, user_id: user_id
    access_token
  end

  def self.get_access_token(code)
    all_params = AuthParam.all
    client_id = get_param_value_by_name all_params, 'client_id'
    client_secret = get_param_value_by_name all_params, 'client_secret'
    redirect_uri = get_param_value_by_name all_params, 'redirect_uri'
    response = VkSender.get_access_token client_id, client_secret, redirect_uri, code
    JSON.parse(response.body)
  end

  def self.get_param_value_by_name(all_params, name)
    all_params.find { |item| item[:name] == name}[:value]
  end
end