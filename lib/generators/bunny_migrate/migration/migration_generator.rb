require 'rails/generators'
require 'rails/generators/migration'

module BunnyMigrate 
  module Generators  
    class MigrationGenerator < Rails::Generators::NamedBase 
      include Rails::Generators::Migration 

      source_root File.expand_path("templates", __dir__)

      desc 'Creates a BunnyMigrate migration'
      def create_migration_file
        migration_template(
          "migration.rb.tt",
          "db/bunny_migrate/#{file_name}.rb"
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
