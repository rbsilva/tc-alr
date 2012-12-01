#namespace :db do
#  task :load_config do
#    if ENV['DATA_WAREHOUSE'] && ENV['DATA_WAREHOUSE'] == 'true'
#      aux_env = Rails.env
#      Rails.env = "data_warehouse_#{aux_env}"
#      ENV['SCHEMA'] = "#{Rails.root}/db/data_warehouse_schema.rb"
#      ActiveRecord::Base.configurations = Rails.application.config.database_configuration
#      ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/dw_migrate'].to_a
#    end
#  end

#  #%w(database_one database_two database_three).each do |db|

##  namespace :test do
##    # desc 'Purge and load data_warehouse_test schema'
##    task :load_schema do
##      # like db:test:purge
##      abcs = ActiveRecord::Base.configurations
##      ActiveRecord::Base.connection.recreate_database(abcs['data_warehouse_test']['database'], postgresql_creation_options(abcs['data_warehouse_test']))
##      # like db:test:load_schema
##      ActiveRecord::Base.establish_connection('data_warehouse_test')
##      ActiveRecord::Schema.verbose = false
##      load("#{Rails.root}/db/data_warehouse_schema.rb")
##    end
##  end
#end
