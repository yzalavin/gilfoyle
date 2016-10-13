module Message
  class Base
    private
    attr_reader :params
    public

    def initialize(params = {})
      @params = params
    end

    %i(text days visits password).each do |field|
      define_method field do
        params[field]
      end

      define_method "#{field}=" do |value|
        params[field] = value
      end
    end
  end
end
