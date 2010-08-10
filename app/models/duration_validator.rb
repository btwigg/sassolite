class DurationValidator < ActiveModel::Validator
  
  def validate(record)
    record.errors[:start] << "Start date must come before end date." if( record.start && record.end && record.start >= record.end )
  end
end