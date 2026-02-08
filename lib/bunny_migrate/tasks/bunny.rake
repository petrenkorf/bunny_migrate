namespace :bunny do
  desc "Run RabbitMQ migrations"
  task :migrate => :environment do
    BunnyMigrate::Migrator.new.migrate
  end

  desc "Rollback last RabbitMQ migration"
  task :rollback => :environment do
    BunnyMigrate::Migrator.new.rollback
  end

  desc "Show migration status"
  task :status => :environment do
    BunnyMigrate::Migrator.new.status
  end

  desc "Install bunny_migrate migrations"
  task :install => :environment do
    source = File.expand_path("../db/migrate", __dir__) 
    target = Rails.root.join("db/migrate")

    FileUtils.mkdir_p(target)

    Dir.glob("#{source}/*.rb").each do |file|
      filename = File.basename(file)
      dest = target.join(filename)

      if File.exist?(dest)
        puts "Skipping #{filename} (already exists)"
      else 
        FileUtils.cp(file, dest)
        puts "Copied #{filename}"
      end
    end
  end
end
