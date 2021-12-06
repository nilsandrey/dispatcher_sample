class Supply < ApplicationRecord
  belongs_to :medication
  belongs_to :cargo

  def weight
    medication.weight * count
  end
end
