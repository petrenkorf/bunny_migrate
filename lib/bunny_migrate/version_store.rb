module BunnyMigrate
  class VersionStore < ::ActiveRecord::Base
    self.table_name = 'rabbitmq_migrations'

    before_save { self.applied_at = Time.now.utc }
  end
end
