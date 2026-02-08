namespace :bunny do
  desc "Run RabbitMQ migrations"
  task :migrate => :environment do
    BunnyMigrate::Migrator.new.migrate
  end

  namespace :migrate do
    desc "Rollback last RabbitMQ migration"
    task :rollback => :environment do
      BunnyMigrate::Migrator.new.rollback
    end

    desc "Show migration status"
    task :status => :environment do
      BunnyMigrate::Migrator.new.status
    end
  end
end
