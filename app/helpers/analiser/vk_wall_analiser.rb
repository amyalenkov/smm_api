class VkWallAnaliser

  def initialize(group_id)
    @group_id = group_id
  end

  def get_posts_for_date(date_from, date_till)
    @date_from = date_from
    @date_till = date_till
    offset = 0
    posts_hash = Array.new
    get_posts offset, posts_hash
  end

  def get_topics_for_date(date_from, date_till)
    @date_from = date_from
    @date_till = date_till
    offset = 0
    topics_hash = Array.new
    get_topics_hash offset, topics_hash
  end

  private

  def get_posts(offset, posts_hash)
    json_response = get_wall offset
    last_index = json_response.size - 1
    json_response.each_with_index do |post, index|
      unless index == 0
        date = post['date']
        if date.to_i >= @date_from.to_datetime.to_i && date.to_i <= @date_till.to_datetime.to_i
          posts_hash.push json_response[index]
        end
        if index == last_index && date.to_i >= @date_from.to_datetime.to_i
          offset = offset +100
          sleep(1.0 / 3.0)
          get_posts offset, posts_hash
        end
      end
    end
    posts_hash
  end

  def get_topics_hash(offset, topics_hash)
    json_response = get_topics offset
    last_index = json_response.size - 1
    json_response.each_with_index do |topic, index|
      unless index == 0
        date = topic['created']
        if date.to_i >= @date_from.to_datetime.to_i && date.to_i <= @date_till.to_datetime.to_i
          topics_hash.push json_response[index]
        end
        if index == last_index && date.to_i >= @date_from.to_datetime.to_i
          offset = offset +100
          sleep(1.0 / 3.0)
          get_topics_hash offset, topics_hash
        end
      end
    end
    topics_hash
  end

  def get_wall(offset)
    vk_sender = VkSender.new @group_id
    response = vk_sender.get_wall 100, offset
    p response.request
    p response.body
    JSON.parse(response.body)['response']
  end

  def get_topics(offset)
    vk_sender = VkSender.new @group_id
    response = vk_sender.get_topics 100, offset
    p response.request
    p response.body
    JSON.parse(response.body)['response']['topics']
  end

end