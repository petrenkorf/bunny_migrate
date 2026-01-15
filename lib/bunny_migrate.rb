# frozen_string_literal: true

require_relative 'bunny_migrate/version'
require_relative 'bunny_migrate/railtie' if defined?(Rails)
require 'bunny_migrate/cli'
require 'bunny_migrate/migrator'

module BunnyMigrate
  class Error < StandardError; end
  # Your code goes here...
end
