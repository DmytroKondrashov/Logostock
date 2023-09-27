class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :timeoutable
  devise :recoverable if %w[development test].include?(Rails.env) || (ENV["DISABLE_PASSWORD_RECOVERY"] != "true" && ENV["MAILGUN_SMTP_PASSWORD"].present?)

end
