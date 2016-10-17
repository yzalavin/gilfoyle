module Message
  class DestroyWorker
    include ::Sidekiq::Worker

    def perform(key)
      Redis.current.del("message:#{key}")
    end
  end
end
