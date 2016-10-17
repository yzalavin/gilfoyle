module Message
  class Error < Base
    def humanize
      case Validator.new(current_params).error_type
      when :missing_text then 'We could not encrypt nothing! Provide some text.'
      when :invalid_hours_or_visits
        'We do not how long to encrypt! Provide hours or/and visits count as an integer value.'
      when :short_password
        'We do not want to harm your data! Provide password with at least six symbols.'
      end
    end
  end
end
