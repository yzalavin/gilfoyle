require "openssl"
require 'digest/sha2'
require 'base64'

module Message
  class Encryptor < Base
    def encrypt!
      # p settings.encryption_algorithm
      # text = BCrypt::Password.create(text)
      # password = BCrypt::Password.create(password)
    end
  end
end
