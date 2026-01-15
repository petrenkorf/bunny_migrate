module BunnyMigrate
  class Railtie < Rails::Railtie
    rake_tasks do
      path = File.expand_path('tasks/bunny.rake', __dir__)
      load path if defined?(Rake.application)
    end
  end
end
