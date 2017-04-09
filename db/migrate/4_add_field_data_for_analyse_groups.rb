require 'active_record'

class AddFieldDataForAnalyseGroups < ActiveRecord::Migration
  def change
    add_column :analyse_groups, :data, :json, default: '{}'
  end
end