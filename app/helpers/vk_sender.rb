class VkSender

  @@url = 'https://api.vk.com/method/'
  @@version = '5.62'

  def initialize(group_id)
    @group_id = group_id
  end

  def get_members
    method_name ='groups.getMembers'
    RestClient.get @@url + method_name, {params: {group_id: @group_id, version: @@version}}
  end

  def get_wall count, offset
    method_name ='wall.get'
    RestClient.get @@url + method_name, {params: {owner_id: '-'+@group_id, count: count, offset: offset, version: @@version}}
  end

  def get_topics count, offset
    method_name ='board.getTopics'

    # 1 — по убыванию даты обновления;
    # 2 — по убыванию даты создания;
    # -1 — по возрастанию даты обновления;
    # -2 — по возрастанию даты создания.
    order = 2

    RestClient.get @@url + method_name, {params: {group_id: @group_id, count: count, offset: offset, version: @@version,
                                                  order: order}}
  end

end