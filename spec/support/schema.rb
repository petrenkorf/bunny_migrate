ActiveRecord::Schema.define do
  create_table :rabbitmq_migrations, force: true do |t|
    t.string :version, null: false
    t.string :applied_at, null: false
  end
end
