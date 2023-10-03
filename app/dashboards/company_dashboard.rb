require "administrate/base_dashboard"

class CompanyDashboard < BaseDashboard
  ATTRIBUTE_TYPES = {
    practices: Field::HasMany.with_options(limit: 25),
    asset_classes: Field::HasMany.with_options(limit: 25),
    job_functions: Field::HasMany.with_options(limit: 25),
    locations: Field::HasMany.with_options(limit: 25),
    id: Field::Number,
    is_request: Field::Boolean,
    url: Field::String,
    name: Field::String,
  }.merge(SHARED_TYPES).freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    practices
    asset_classes
    job_functions
    locations
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    name
    practices
    asset_classes
    job_functions
    locations
    url
  ].concat(SHARED_SHOW_PAGE_ATTRIBUTES).freeze

  FORM_ATTRIBUTES = %i[
    name
    practices
    asset_classes
    job_functions
    locations
    url
    is_request
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(company)
    company.name
  end
end
