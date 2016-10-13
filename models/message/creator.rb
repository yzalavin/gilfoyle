require 'securerandom'
require 'json'

module Message
  class Creator < Base
    def store!
      return false unless valid?
      encrypt
      ::Redis.current.set "message:#{store_key}", to_json
    end

    private

    def encrypt
      Encryptor.new(self)
    end

    def valid?
      Validator.new
    end

    def store_key
      SecureRandom.hex
    end

    def to_json
      {}.tap { |hash| Base::PARAMS.each { |param| hash[param] = send(param) }}
    end
  end
end
