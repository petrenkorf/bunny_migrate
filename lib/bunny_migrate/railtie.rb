module BunnyMigrate
  class Railtie < Rails::Railtie
    Dir[File.join(__dir__, 'tasks/*.rake')].each { load it }
  end
end
