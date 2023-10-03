require "administrate/base_dashboard"

class CsvUploadDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    csv_filename: Field::String,
    csv_content: Field::String.with_options(searchable: false),
    companies_applied: Field::String.with_options(searchable: false),
    companies_failed: Field::String.with_options(searchable: false),
    companies_discarded: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    companies_applied_count: Field::Number,
    companies_discarded_count: Field::Number,
    companies_failed_count: Field::Number,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    csv_filename
    companies_applied_count
    companies_discarded_count
    companies_failed_count
    user
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    user
    csv_filename
    csv_content
    companies_applied
    companies_discarded
    companies_failed
    created_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    csv_filename
    created_at
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
