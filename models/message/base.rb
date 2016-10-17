module Message
  class Base
    PARAMS = %i(text hours visits password encryption_iv)

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

    def current_params
      {}.tap { |hash| Base::PARAMS.each { |param| hash[param] = send(param) }}
    end

    def encrypt!
      Encryptor.new(current_params).encrypt!
    end

    def valid?
      Validator.new(current_params).valid?
    end
  end
end
