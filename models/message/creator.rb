require 'securerandom'
require 'json'

module Message
  class Creator < Base
    def store!
      return false unless valid?
      Redis.current.set "message:#{store_key}", to_encrypted_json
      store_key
    end

    private

    def store_key
      @store_key ||= SecureRandom.hex
    end

    def to_encrypted_json
      encrypt!.current_params.to_json
    end
  end
end
