module BunnyMigrate
  class Migration
    def up; end
    def down; end

    protected

    def channel = Connection.channel

    def create_exchange(name, **opts) = channel.exchange(name, opts)

    def delete_exchange(name) = channel(name).delete

    def create_queue(name, **opts) = channel.queue(name, opts)

    def delete_queue(name) = channel.queue(name).delete

    def bind(exchange, queue, routing_key)
      channel.queue(queue).bind(exchange, routing_key:)
    end
  end
end
