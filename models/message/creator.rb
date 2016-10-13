module Message
  class Creator < Base
    def valid?
      Validator.new
    end

    def store!
      valid?
      encrypt
    end

    def encrypt
      Encryptor.new
    end
  end
end
