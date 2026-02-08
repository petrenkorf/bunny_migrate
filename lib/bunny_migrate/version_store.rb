module BunnyMigrate
  class VersionStore < ::ActiveRecord::Base
    self.table_name = 'bunny_migrations'

    validates :version, :applied_at, presence: true

    before_validation { self.applied_at = Time.now.utc }
  end
end
