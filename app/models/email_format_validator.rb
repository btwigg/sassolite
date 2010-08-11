class EmailFormatValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    if value !~ Regexp.new( "^[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
      record.errors[attribute] << "Is not a valid email address"
    end
  end
end