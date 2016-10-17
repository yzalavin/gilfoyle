require "openssl"
require 'digest/sha2'
require 'base64'

module Message
  class Encryptor < Base
    def encrypt!
      %i(text password).each do |param|
        encryption = set_up_encryption
        crypt = encryption.update(public_send(param)) + encryption.final
        public_send("#{param}=", Base64.encode64(crypt))
      end
      encryption_iv = iv
      self
    end

    def decrypt!
      %i(text password).each do |param|
        decryption = set_up_decryption
        crypt = decryption.update(Base64.decode64(public_send(param))) + decryption.final
        public_send("#{param}=", crypt)
      end
      self
    end

    private

    def algorithm
      CONFIG['encryption_algorithm']
    end

    def key
      @key ||= Digest::SHA256.new.tap { |d| d.update(CONFIG['encryption_key']) }.digest
    end

    def iv
      encryption_iv || OpenSSL::Cipher.new(algorithm).random_iv
    end

    def set_up_encryption
      OpenSSL::Cipher.new(algorithm).tap do |aes|
        aes.encrypt
        aes.key = key
        aes.iv = iv
      end
    end

    def set_up_decryption
      OpenSSL::Cipher.new(algorithm).tap do |aes|
        aes.decrypt
        aes.key = key
        aes.iv = iv
      end
    end
  end
end
