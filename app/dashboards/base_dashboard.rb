class BaseDashboard < Administrate::BaseDashboard
    SHARED_TYPES = {
      created_at: Field::DateTime.with_options(format: "%a, %d %b %Y %I:%M%p", timezone: "Eastern Time (US & Canada)"),
      updated_at: Field::DateTime.with_options(format: "%a, %d %b %Y %I:%M%p", timezone: "Eastern Time (US & Canada)"),
    }.freeze
  
    SHARED_SHOW_PAGE_ATTRIBUTES = %i[
      created_at
      updated_at
    ].freeze
  end
  