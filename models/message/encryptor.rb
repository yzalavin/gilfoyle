require "openssl"
require 'digest/sha2'
require 'base64'

module Message
  class Encryptor < Base
    def encrypt!
      %i(text password).each do |param|
        current = public_send(param)
        next if current.nil? || current.strip.length.zero?
        encryption = set_up_encryption
        crypt = encryption.update(current) + encryption.final
        public_send("#{param}=", Base64.encode64(crypt))
      end
      public_send(:encryption_iv=, iv)
      self
    end

    def decrypt!
      %i(text password).each do |param|
        current = public_send(param)
        next if current.nil? || current.strip.length.zero?
        decryption = set_up_decryption
        crypt = decryption.update(Base64.decode64(current)) + decryption.final
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
      @iv ||= SecureRandom.hex
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
        aes.iv = encryption_iv
      end
    end
  end
end
