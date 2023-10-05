class Admin::ApplicationController < Administrate::ApplicationController
  before_action :authenticate_user!
  before_action :set_time_zone_from_user

  # helper ThriveRudyNew::Application.helpers

  def records_per_page
    params[:per_page] || 20
  end

  def default_sorting_attribute
    :name
  end

  def set_time_zone_from_user
    Time.zone = ActiveSupport::TimeZone.new(current_user.time_zone)
  end
end
