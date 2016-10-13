module Message
  class Base
    PARAMS = %i(text days visits password encryption_iv)

    private
    attr_reader :params
    public

    def initialize(params = {})
      @params = params
    end

    PARAMS.each do |field|
      define_method field do
        params[field]
      end

      define_method "#{field}=" do |value|
        params[field] = value
      end
    end
  end
end
