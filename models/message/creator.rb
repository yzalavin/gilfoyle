module Message
  class Create
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def valid?
      Validator.new
    end

    def store!
      valid?
    end
  end
end
