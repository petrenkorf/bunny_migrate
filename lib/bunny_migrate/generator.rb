def generator(name)
  timestamp = Time.new.strftime('%Y%m%d%H%M%S')
  File.write(
    "bunny/migrate/#{timestamp}_#{name}.rb",
    <<~RUBY
      class #{name.camelize} < BunnyMigrate::Migration
        def up
        end

        def down
        end
      end
    RUBY
  )
end
