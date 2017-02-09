require 'spec_helper'

describe 'check vk http helper' do

  it 'get vk group members by group id' do
    vk_sender = VkSender.new '38761578'
    response = vk_sender.get_members
    expect(response.code).to eq 200
    json_body = JSON.parse(response.body)
    expect(json_body['response']['count']).to be
  end

  it 'get vk group wall by group id' do
    vk_sender = VkSender.new '31333866'
    response = vk_sender.get_wall 3, 0
    expect(response.code).to eq 200
    json_body = JSON.parse(response.body)
    expect(json_body['response']).to be
  end

  it 'get vk group topics' do
    vk_sender = VkSender.new '31333866'
    response = vk_sender.get_topics 3, 0
    expect(response.code).to eq 200
    json_body = JSON.parse(response.body)
    expect(json_body['response']).to be
  end

  it 'get vk group photo albums' do
    vk_sender = VkSender.new '31333866'
    response = vk_sender.get_photo_albums
    expect(response.code).to eq 200
    json_body = JSON.parse(response.body)
    expect(json_body['response']).to be
  end
end