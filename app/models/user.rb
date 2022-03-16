class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :before_save

  validates :name, presence: true,
            length: {maximum: Settings.const.maximum_name_length}

  validates :email, presence: true,
            length: {maximum: Settings.const.maximum_email_length},
            format: {with: Settings.const.valid_email_regex},
            uniqueness: true

  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.const.minimum_password_length},
            allow_nil: true

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def before_save
    email.downcase!
  end
end
