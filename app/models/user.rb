class User < ApplicationRecord
  before_save :before_save

  validates :name, presence: true,
            length: {maximum: Settings.constant.maximum_name_length}

  validates :email, presence: true,
            length: {maximum: Settings.constant.maximum_email_length},
            format: {with: Settings.constant.valid_email_regex},
            uniqueness: true

  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.constant.minimum_password_length}

  private

  def before_save
    email.downcase!
  end
end
