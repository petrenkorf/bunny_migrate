module BunnyMigrate
  class VersionStore < ::ActiveRecord::Base
    self.table_name = 'rabbitmq_migrations'

    validates :version, :applied_at, presence: true

    before_save { self.applied_at = Time.now.utc }
  end
end
