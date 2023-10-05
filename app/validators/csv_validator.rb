# frozen_string_literal: true

require "csv"

class CsvValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? # presence validation should handle this

    parsed_csv = ::CSV.parse(value) # can raise MalformedCSVError

    headers = parsed_csv[0]
    parsed_csv.drop(1).each do |row|
      [headers, row].transpose.to_h # can raise IndexError
    end
  rescue ::CSV::MalformedCSVError
    record.errors.add attribute, :unparseable, mime: "CSV"
  rescue IndexError
    record.errors.add attribute, "has different number of columns and headers"
  end
end
