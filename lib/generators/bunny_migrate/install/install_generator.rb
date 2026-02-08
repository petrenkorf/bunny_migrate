require 'rails/generators'
require 'rails/generators/migration'

module BunnyMigrate 
  module Generators 
    class InstallGenerator < Rails::Generators::Base 
      include Rails::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      desc 'Installs BunnyMigrate migration'
      def copy_migration 
        migration_template(
          "create_rabbitmq_migrations.rb",
          "db/migrate/create_rabbitmq_migrations.rb"
        )
      end

      def self.next_migration_number(dirname)
        if Rails.application.config.active_record.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          format("%.3d", current_migration_number(dirname) + 1)
        end
      end
    end
  end
end
