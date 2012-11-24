class DwDbMigrator < DwDb
  def self.migrate
    Rake::Task["db:migrate"].reenable
    Rake::Task["db:migrate"].invoke
  end
end
