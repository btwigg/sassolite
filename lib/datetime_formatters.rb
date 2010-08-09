module DatetimeFormatters
  
  def self.included(base)
    base.extend(DatetimeFormatterMethods)
  end
  
  module DatetimeFormatterMethods
  
    # Return back a date column for ActiveRecord forms in MM/DD/YYYY format
    def formatted_date(*attributes)
      attributes.each do |attribute|
        class_eval <<-CODE
          def date_formatted_#{attribute}
            self.#{attribute}.nil? ? "" : self.#{attribute}.strftime("%m/%d/%Y")
          end
      
          def date_formatted_#{attribute}=(date_string)
            self.#{attribute} = date_string.empty? ? nil : Date.parse(date_string)
          end
        CODE
      end
    end

    # Return back a time column for ActiveRecord forms in HH/MM/SS AM|PM format
    def formatted_time(*attributes)
      attributes.each do |attribute|
        class_eval <<-CODE
          def time_formatted_#{attribute}
            self.#{attribute}.nil? ? "" : self.#{attribute}.strftime("%I:%M:%S %p")
          end
      
          def time_formatted_#{attribute}=(time_string)
            self.#{attribute} = time_string.empty? ? nil : Time.parse(time_string)
          end
        CODE
      end
    end
  
  end
  
end