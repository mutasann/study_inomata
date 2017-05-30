class DateTimeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless DateTime.now <= value then
      record.errors[attribute] << I18n.t('errors.messages.invalid_date')
    end
  end
end

#unless DateTime.now <= @reservation then
#else record.errors[attribute] << I18n.t('errors.messages.invalid.date')

# record.errors[attribute] << I18n.t('errors.messages.invalid_date_format')unless DateTime.now <= value
#
# begin
# rescue
# record.errors[attribute] << I18n.t('errors.messages.invalid_date')
# end
