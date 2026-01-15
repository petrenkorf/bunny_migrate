module BunnyMigrate
  class VersionStore < ::ActiveRecord::Base
    self.table_name = 'rabbitmq_migrations'
  end
end
