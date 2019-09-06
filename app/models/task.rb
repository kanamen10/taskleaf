class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validate :validate_name_not_including_comma
  # before_validation :set_nameless_name

  def self.ransackable_attributes(auth_object = nil)
      %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private
  def validate_name_not_including_comma
  errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  def set_nameless_name
    self.name = '名前無し' if name.blank?
  end

  belongs_to :user

  # scope :recent, -> { order(created_at: :desc) }
end
