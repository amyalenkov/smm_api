$db = SQLite3::Database.new 'vk.db'
module VkDB
  def self.setup(database)
    database.execute(
        <<-SQL
      CREATE TABLE vk_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id VARCHAR(64) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL
        );
    SQL
    )
  end

  def self.seed(groups_ids, database)
    insert =  <<-SQL
      INSERT INTO vk_groups
      values (Null,?,DATETIME('now'),DATETIME('now'))
    SQL

    groups_ids.each do |id|
      database.execute( insert,
                        id
      )
    end
  end
end