require 'active_record'

class AuthParams < ActiveRecord::Migration
  def change
    create_table :auth_params do |t|
      t.string :name
      t.string :value
    end
  end
end