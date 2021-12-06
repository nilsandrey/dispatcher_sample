class Cargo < ApplicationRecord
  belongs_to :drone
  has_many :supplies, dependent: :destroy

  scope :actived, -> { where(:active => true) }

  def weight
    supplies.includes(:medication).sum(:weight)
  end

  def load_supply(medication, count)
    supply = supplies.new
    supply.medication = medication
    supply.count = count
    supply.save
  end
end
