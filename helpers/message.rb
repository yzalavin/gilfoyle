module Helpers
  class Message
    attr_reader :message

    def initialize(message = nil)
      @message = message
    end

    def params(params)
      {}.tap { |hash| ::Message::Base::PARAMS.each { |param| hash[param] = params[param] }}
    end
  end
end
