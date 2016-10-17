require 'securerandom'
require 'json'

module Message
  class Creator < Base
    def store!
      return Message::Error.new(current_params) unless valid?
      Redis.current.set "message:#{store_key}", to_encrypted_json
    end

    def store_key
      @store_key ||= SecureRandom.hex
    end

    private

    def to_encrypted_json
      current_params.to_json
      # encrypt!.current_params.to_json
    end
  end
end
