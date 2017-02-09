require 'spec_helper'

describe 'check vk analiser' do

  # it 'get vk group posts for dates' do
  #   analiser = VkWallAnaliser.new '31333866'
  #   posts = analiser.get_posts_for_date '2016-02-01 00:00:00 +0300', '2016-02-02 00:00:00 +0300'
  #   posts.each do |post|
  #     p Time.at post['date']
  #     p post['date']
  #   end
  #   expect(posts.size).to eq 2
  # end
  #
  # it 'get vk group topics for dates' do
  #   analiser = VkWallAnaliser.new '31333866'
  #   topics = analiser.get_topics_for_date '2010-02-05 00:00:00 +0300', '2017-02-04 00:00:00 +0300'
  #   expect(topics.size).to eq 13
  # end

  it 'get all vk group photo albums' do
    analiser = VkWallAnaliser.new '31333866'
    photo_albums = analiser.get_all_photo_albums
    expect(photo_albums.size).to eq 29
  end

  it 'get vk group photo albums which was updated' do
    analiser = VkWallAnaliser.new '31333866'
    photo_albums = analiser.get_photo_albums_updated_for_date '2016-02-05 00:00:00 +0300', '2017-02-04 00:00:00 +0300'
    expect(photo_albums.size).to eq 3
  end
end