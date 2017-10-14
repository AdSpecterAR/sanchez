class ApiKey < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_app

  validates :key, uniqueness: true, presence: true, on: :create
  validates :developer_app, presence: true
  validate :key_cannot_change

  ### CALLBACKS ###

  after_initialize :generate_key, if: :new_record?


  private


  def generate_key
    self.key = SecureRandom.hex
  end

  def key_cannot_change
    if self.persisted?
      if encrypted_key_changed?
        errors.add(:key, "cannot change key")
      end
    end
  end
end
