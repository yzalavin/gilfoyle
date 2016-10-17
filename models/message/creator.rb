require 'securerandom'
require 'json'

module Message
  class Creator < Base
    def store!
      return Message::Error.new(current_params) unless valid?
      Redis.current.set "message:#{store_key}", to_encrypted_json
      create_background_process
      self
    end

    def store_key
      @store_key ||= SecureRandom.hex
    end

    private

    def to_encrypted_json
      current_params.to_json
      # encrypt!.current_params.to_json
    end

    def create_background_process
      return unless hours.to_i > 0
      Message::DestroyWorker.perform_in(5, store_key)
      # Message::DestroyWorker.perform_in(hours.to_i * 24 * 60 * 60, store_key)
    end
  end
end
