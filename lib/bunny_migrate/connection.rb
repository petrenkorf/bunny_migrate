module BunnyMigrate
  class Connection
    def self.channel
      @channel ||= begin
        conn = Bunny.new(ENV.fetch('RABBITMQ_URL', nil))
        conn.start
        conn.create_channel
      end
    end
  end
end
