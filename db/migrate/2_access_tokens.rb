require 'active_record'

class AccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.integer :user_id
      t.string :access_token
    end
  end
end