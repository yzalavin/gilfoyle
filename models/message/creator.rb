module Message
  class Creator < Base
    def valid?
      Validator.new
    end

    def store!
      valid?
    end
  end
end
