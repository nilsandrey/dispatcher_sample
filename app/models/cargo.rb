class Cargo < ApplicationRecord
  belongs_to :drone
  has_many :supplies, dependent: :destroy
  has_many :medications, through: :supplies

  scope :actived, -> { where(:active => true) }

  def weight
    supplies.includes(:medication).sum(:weight)
  end

  def load(medication, count)
    supplies.create(medication: medication, count: count)
  end
end
