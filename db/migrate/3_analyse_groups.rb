require 'active_record'

class AnalyseGroups < ActiveRecord::Migration
  def change
    create_table :analyse_groups do |t|
      t.string :group_id
      t.datetime :start_time
      t.datetime :finish_time
    end
  end
end