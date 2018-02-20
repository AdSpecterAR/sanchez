class User < ApplicationRecord

  ### INCLUDES ###

  has_secure_password

  ### CONSTANTS ###

  ACCOUNT_TYPE_ADVERTISER = 'advertiser'
  ACCOUNT_TYPE_DEVELOPER = 'developer'
  VALID_ACCOUNT_TYPES = [ACCOUNT_TYPE_ADVERTISER, ACCOUNT_TYPE_DEVELOPER]


  ### ASSOCIATIONS ###

  has_many :ad_units, dependent: :destroy
  has_many :developer_apps, dependent: :destroy

  ### SCOPES ###


  ### VALIDATIONS ###

  validates :first_name, :last_name, :email, presence: true
  validate :password_valid
  validate :email_presence
  validate :unique_email


  ### CALLBACKS ###

  before_validation :downcase_email


  ### CLASS METHODS ###


  def self.from_token_payload payload
    payload['sub']
  end


  ### INSTANCE_METHODS ###

  def full_name
    "#{first_name} #{last_name}"
  end


  private


  def downcase_email
    self.email = email.downcase if email.present?
  end

  def password_valid
    # do not run validation if the password is not being set
    return unless instance_variable_defined?(:@password)

    # password cannot be nil
    errors.add(:password, "cannot be empty") and return if password.nil?

    # password has to be at least 8 characters long
    errors.add(:password, "must be at least 8 characters long") if password.length < 8

    # password must contain at least one number
    errors.add(:password, "must contain at least one number") if password.gsub(/[^0-9 ]/i, '').length == 0

    # password must contain at least one character
    errors.add(:password, "must contain at least one character") if password.gsub(/[^a-z ]/i, '').length == 0
  end

  def email_presence
    if email.blank?
      errors.add(:email, "cannot be blank")
      return
    end

    # NOTE: Underscore fails here and is valid - see http://stackoverflow.com/a/2183140/3162992
    if !(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i === email)
      errors.add(:email, "format incorrect")
      return
    end
  end

  def unique_email
    # users = User.where("? = ANY (email)", email).where.not(id: id)
    users = []
    if users.count > 0
      errors.add(:email, "email not unique")
      return
    end
  end
end
