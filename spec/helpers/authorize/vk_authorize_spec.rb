require 'spec_helper'

context 'auth vk' do

  it 'check vk url' do
    expect(VkAuthorize.get_auth_url).to start_with 'https://'
  end

  # it 'check save token' do
  #   expect(VkAuthorize.send_code_and_save_token'1').to start_with 'https://'
  # end
end