class VkSender

  @@url = 'https://api.vk.com/method/'
  @@auth_url = 'https://oauth.vk.com/'
  @@version = '5.62'

  def initialize(group_id)
    @group_id = group_id
  end

  def self.get_access_token(client_id, client_secret, redirect_uri, code)
    method_name ='access_token'
    RestClient.get @@auth_url + method_name, {params: {client_id: client_id, client_secret: client_secret,
                                                       redirect_uri: redirect_uri, code: code}}
  end

  def get_members
    method_name ='groups.getMembers'
    RestClient.get @@url + method_name, {params: {group_id: @group_id, version: @@version}}
  end

  def get_wall(count, offset)
    method_name ='wall.get'
    RestClient.get @@url + method_name, {params: {owner_id: '-'+@group_id, count: count, offset: offset, version: @@version}}
  end

  def get_topics(count, offset)
    method_name ='board.getTopics'

    # 1 — по убыванию даты обновления;
    # 2 — по убыванию даты создания;
    # -1 — по возрастанию даты обновления;
    # -2 — по возрастанию даты создания.
    order = 2

    RestClient.get @@url + method_name, {params: {group_id: @group_id, count: count, offset: offset, version: @@version,
                                                  order: order}}
  end

  def get_photo_albums
    method_name ='photos.getAlbums'
    RestClient.get @@url + method_name, {params: {owner_id: '-'+@group_id, version: @@version}}
  end

  def get_video_albums(count, offset, access_token)
    method_name ='video.getAlbums'
    RestClient.get @@url + method_name, {params: {owner_id: @group_id, count: count, offset: offset, version: $version,
                                                  access_token: access_token}}
  end

end