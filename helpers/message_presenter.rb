module Helpers
  class MessagePresenter
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def duration
      case
      when message.hours.to_i > 0 && message.visits.to_i > 0
         "#{message.hours} hour(s) or #{message.visits} visit(s)"
      when message.hours.to_i > 0
        "#{message.hours} hour(s)"
      when message.visits.to_i > 0
        "#{message.visits} visit(s)"
      end
    end
  end
end
