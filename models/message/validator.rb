module Message
  class Validator
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def provide
      true
    end
  end
end
