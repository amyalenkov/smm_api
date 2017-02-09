$db = SQLite3::Database.open 'vk.db'
class VkGroups
  attr_reader :id, :group_id, :created_at, :updated_at

  def initialize(group_id)
    @group_id = group_id
  end

  def save
    insert =  <<-SQL
      INSERT INTO vk_groups
      values (NULL,?,DATETIME('now'),DATETIME('now'))
    SQL
    $db.execute( insert,
                 self.group_id
    )
  end

  def self.get_all
    $db.execute('select * from vk_groups order by id')
  end

  def self.get_by_group_id(group_id_value)
    $db.execute("select * from vk_groups where group_id="+group_id_value.to_s+" order by id")
  end

  def self.where(attribute, value)
    query = "select * from vk_groups where #{attribute}=#{value}"
    id = $db.execute(query)
  end

end