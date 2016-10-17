module Message
  class Validator < Base
    def valid?
      return false unless text_present?
      return false unless days_or_visits_present?
      return false unless valid_password?
      true
    end

    def error_type
      case
      when !text_present? then :missing_text
      when !days_or_visits_present? then :invalid_days_or_visits
      when !valid_password? then :short_password
      end
    end

    private

    def text_present?
      text && !text.strip.length.zero?
    end

    def days_or_visits_present?
      days.to_i > 0 || visits.to_i > 0
    end

    def valid_password?
      return true if password.nil? || password.length == 0
      password.strip.length > 5
    end
  end
end
