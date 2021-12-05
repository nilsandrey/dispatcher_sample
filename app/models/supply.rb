class Supply < ApplicationRecord
  belongs_to :medication
  belongs_to :cargo

  before_update :check_on_update
  before_create :check_on_update

  private

  ##
  # Callback, put in before_update.
  # @raise <tt>ActiveRecord::RecordNotSaved</tt> if biz rule violated.
  #
  def check_on_update
    max = cargo.drone.weight_limit

    # Add all current supplies to check if piled up above max...
    piled_up = 0
    cargo.supplies.each do |sibling_supply|
      piled_up += sibling_supply.count * sibling_supply.medication.weight
    end

    abort_with_error('supplies', Supply.full_drone_message(piled_up, max)) if piled_up > max
  end


  def self.full_drone_message(requirement, max)
    "drone from being loaded with more weight (#{requirement}) that it can carry #{max}"
  end
end
