module Message
  class Finder
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def find
      return false unless record
      Base.new params
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
  end
end
