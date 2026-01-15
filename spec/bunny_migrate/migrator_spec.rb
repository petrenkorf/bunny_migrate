require 'spec_helper'
require 'bunny_migrate/migrator'
require 'bunny_migrate/version_store'

RSpec.describe BunnyMigrate::Migrator do
  let(:migrator) { described_class.new }

  before { BunnyMigrate::VersionStore.delete_all }

  describe '#migrate' do
    let(:migration_class) { class_double('TestMigration').as_stubbed_const }
    let(:migration_instance) { instance_double('TestMigration') }

    it 'calls up pending migrations and records them' do
      allow(migration_class).to receive(:new).and_return(migration_instance)

      allow(migration_instance).to receive(:up)
      allow(migration_instance).to receive(:down)

      allow(migrator).to receive(:migrations).and_return([migration_class])
      allow(migrator).to receive(:applied_versions).and_return([])

      expect(migration_instance).to receive(:up)
      expect { migrator.migrate }.to change { BunnyMigrate::VersionStore.count }.by(1)
    end
  end
end
