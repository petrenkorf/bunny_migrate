require 'thor'

module BunnyMigrate
  class CLI < Thor
    desc 'migrate', 'Run pending migrations'
    def migrate
      Migrator.new.migrate
    end

    desc 'rollback', 'Rollback last migration'
    def rollback
      Migrator.new.rollback
    end

    desc 'status', 'Show status'
    def status
      Migrator.new.status
    end
  end
end
