class SetupBunnyMigrationsSchema < ActiveRecord::Migration[7.1]
  def change
    create_table :bunny_migrations do |t| 
      t.string :version, null: false
      t.datetime :applied_at, null: false
    end

    add_index :bunny_migrations, :version, unique: true
  end
end
