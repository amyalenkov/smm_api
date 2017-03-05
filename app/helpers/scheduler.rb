require 'rufus-scheduler'

class Scheduler

  def self.set_analyse
    scheduler = Rufus::Scheduler.new

    scheduler.cron '00 00 * * *' do
      puts 'start analyse'
      VkGroupAnalyzer.analyse_all_groups
      puts 'finish analyse'
    end

    scheduler.join
  end
end