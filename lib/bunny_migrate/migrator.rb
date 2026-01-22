module BunnyMigrate
  class Migrator
    def migrate
      pending.each do |migration|
        migration.new.up
        record(migration)
      end
    end

    def rollback
      last = applied_migrations.last
      return puts 'Nothing to rollback' unless last

      last.new.down
      remove(last)
    end

    def status
      puts 'Migration status:'

      puts applied_versions
      migrations.each do |migration|
        if applied_versions.include?(migration.name)
          puts "  [x] #{migration.name}"
        else
          puts "  [ ] #{migration.name}"
        end
      end
    end

    private

    def migrations
      Dir['bunny_migrate/migrate/*.rb'].sort.map do |file|
        require file
        Object.const_get(classify(File.basename(file, '.rb')))
      end
    end

    def applied_versions
      BunnyMigrate::VersionStore.pluck(:version)
    end

    def applied_migrations
      applied_versions.map { |name| Object.const_get(name) }
    end

    def pending
      migrations.reject { |m| applied_versions.include?(m.name) }
    end

    def record(migration)
      BunnyMigrate::VersionStore.create!(version: migration.name)
    end

    def remove(migration)
      BunnyMigrate::VersionStore.where(version: migration.name).delete_all
    end

    def classify(str)
      str.split('_').map(&:capitalize).join
    end
  end
end
