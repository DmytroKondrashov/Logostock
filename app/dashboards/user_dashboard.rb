require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    remember_created_at: Field::DateTime,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    email
    encrypted_password
    remember_created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    email
    encrypted_password
    remember_created_at
    reset_password_sent_at
    reset_password_token
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    email
    encrypted_password
    remember_created_at
    reset_password_sent_at
    reset_password_token
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(user)
    user.name
  end
end
