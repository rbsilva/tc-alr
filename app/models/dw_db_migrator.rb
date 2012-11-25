class DwDbMigrator < DwDb
  require 'rake'

  def self.migrate
    TC::Application.load_tasks
    Rake::Task["db:migrate"].reenable
    Rake::Task["db:migrate"].invoke
  end
end
