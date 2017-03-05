class VkGroupAnalyzer

  def self.analyse_all_groups
    all_groups = AnalyseGroup.all
    all_groups.each do |group|
      analyse_group group['group_id']
    end
  end

  def self.analyse_group(group_id)

  end

end