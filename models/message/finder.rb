module Message
  class Finder
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def find
      return false unless record
      Base.new(params).tap do |message|
        message.visits = message.visits - 1
        message.visits.zero? ? destroy : decrement_counter(message)
      end
    end

    private

    def record
      @record ||= Redis.current.get("message:#{key}")
    end

    def params
      {}.tap do |hash|
        JSON.parse(record).each do |k, v|
          hash[k.to_sym] = %w(days visits).include?(k) ? v.to_i : v
        end
      end
    end

    def destroy
      Redis.current.del("message:#{key}")
    end

    def decrement_counter(message)
      Redis.current.set "message:#{key}", message.current_params.to_json
    end
  end
end
