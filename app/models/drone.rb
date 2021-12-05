class Drone < ApplicationRecord
  validates :serial_number, presence: true
  validates :serial_number, length: { maximum: 100 }
  validates :serial_number, uniqueness: true
  validates :battery, numericality: { in: 0..100 }

  before_update :check_on_update

  ##
  # Use model column as an enum
  enum model: %i[lightweight middleweight cruiserweight heavyweight]

  ##
  # Use state column as an enum with suffix for the values. (e.g. `idle_state`)
  # State has suffix because "loaded" interfere with already defined symbols (by the framework)
  enum state: %i[idle loading loaded delivering delivered returning], _suffix: true

  ##
  # Callback, put in before_update causes <tt>ActiveRecord::RecordNotSaved</tt>.
  #
  def check_on_update
    if state_was != 'loading' && loading_state? && battery < 25 # TODO: Substitute with ENV var
      errors.add(:state, 'Battery level to low for loading')
      throw :abort
    end
  end
end
