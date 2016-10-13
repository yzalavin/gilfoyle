module Message
  class Validator < Base
    def valid?
      return false unless text_present?
      return false unless days_or_visits_present?
      return false unless valid_password?
      true
    end

    private

    def text_present?
      text && !text.strip.length.zero?
    end

    def days_or_visits_present?
      days.to_i > 0 || visits.to_i > 0
    end

    def valid_password?
      return true if password.nil?
      password.strip.length > 5
    end
  end
end
