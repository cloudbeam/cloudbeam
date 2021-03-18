class FileValidator < ActiveModel::Validator
  def validate(record)
    matching_files = Document.where(user_id: record[:user_id])
                             .where(expired_at: nil)
                             .where(name: record[:name]).to_a

    if matching_files.size > 1
      record.errors.add(:name, "You already have an active file by that name.")
    end
  end
end
