module FoundationErrorStyling
  module ViewHelpers
    def flash_class(name)
      case name
      when :notice
        return "alert-box"
      when :error
        return ["alert-box","alert"]
      else
      return "alert-box"
      end
    end
  end
end