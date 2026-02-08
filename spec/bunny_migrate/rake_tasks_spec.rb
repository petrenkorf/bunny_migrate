require 'rails'
require 'rake'
require_relative '../../lib/bunny_migrate'

RSpec.describe 'BunnyMigrate Rake tasks' do
  before(:all) { Rails.application.load_tasks }

  it { expect(Rake::Task.task_defined?('bunny:install')).to be true }

  it { expect(Rake::Task.task_defined?('bunny:migrate')).to be true }

  it { expect(Rake::Task.task_defined?('bunny:rollback')).to be true }

  it { expect(Rake::Task.task_defined?('bunny:status')).to be true }
end
