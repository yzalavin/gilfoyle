module Message
  class DestroyWorker
    include ::Sidekiq::Worker

    def perform(sleep_time)
      sleep sleep_time
    end
  end
end
