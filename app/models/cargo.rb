class Cargo < ApplicationRecord
  belongs_to :drone
  has_many :supplies, dependent: :destroy
  has_many :medications, through: :supplies

  scope :active, -> { where(:active => true) }
end
