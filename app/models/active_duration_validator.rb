class ActiveDurationValidator < ActiveModel::Validator
  
  def validate(record)
    if(record.new_record? && record.project)
      # if there are any records for this project that have end date between our start and end, fail
      conflicts = record.project.project_durations.where(["start <= ? and end >= ?", record.start, record.start])
      if conflicts.any?
        record.errors[:base] << "Cannot create new record.  An duration exists that overlaps with this time period"
      end
    end
  end
end