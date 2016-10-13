require "openssl"
require 'digest/sha2'
require 'base64'

module Message
  class Encryptor < Base
    def encrypt!
      %i(text password).each do |param|
        cipher = aes.update(public_send(param))
        cipher << aes.final
        public_send("#{param}=", [cipher].pack('m'))
      end
      encryption_iv = iv
    end

    private

    def algorithm
      CONFIG['encryption_algorithm']
    end

    def key
      @key ||= Digest::SHA256.new.tap { |d| d.update(CONFIG['encryption_key']) }.digest
    end

    def iv
      @iv ||= OpenSSL::Cipher::Cipher.new(algorithm).random_iv
    end

    def aes
      OpenSSL::Cipher::Cipher.new(algorithm).tap do |aes|
        aes.encrypt
        aes.key = key
        aes.iv = iv
      end
    end
  end
end
