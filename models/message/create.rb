module Message
  class Create
    attr_reader :params

    def initialize(params)
      @params = params
    end
  end
end
