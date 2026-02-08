# frozen_string_literal: true

require_relative 'bunny_migrate/version'
require_relative 'bunny_migrate/railtie' if defined?(Rails)
require 'bunny_migrate/migrator'
require 'bunny_migrate/version_store'

module BunnyMigrate
  class Error < StandardError; end
  # Your code goes here...
end
