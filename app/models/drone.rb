class Drone < ApplicationRecord
  validates :serial_number, presence: true
  validates :serial_number, length: { maximum: 100 }
  validates :serial_number, uniqueness: true
  validates :battery, numericality: { in: 0..100 }
  validates :model, presence: true

  before_update :check_on_update

  ##
  # Use model column as an enum
  enum model: %i[lightweight middleweight cruiserweight heavyweight]

  ##
  # Use state column as an enum with suffix for the values. (e.g. `idle_state`)
  # State has suffix because "loaded" interfere with already defined symbols (by the framework)
  enum state: %i[idle loading loaded delivering delivered returning], _suffix: true

  has_many :cargos, dependent: :nullify

  ##
  # Defines the active cargo. Safe to call first because logic allows only one active cargo 
  # per drone at a time.
  #
  def active_cargo
    cargos.actived.first
  end

  ##
  # Add to the active cargo the specified count of the specified medication. If the cargo is
  # not created (idle drone), then create it and add this as the first item.
  #
  # @param [Medication] medication.
  #
  def load(medication, count)
    throw_error("Drone can't load cargo while in state #{state}") unless idle_state? || loading_state?

    ActiveRecord::Base.transaction do
      cargo = cargos.create if idle_state?
      cargo = active_cargo if loading_state?
      cargo.load(medication, count)

      throw_error(overload_message(cargo.weight)) if cargo.weight > weight_limit
    end    
  end

  def cancel!
    if loading_state? || loaded_state?
      active_cargo.destroy! if active_cargo
      idle_state!
    else
      throw_error("Drone state can't be canceled: #{state}")
    end
  end

  private

  def overload_message(weight)
    "drone from being loaded with more weight (#{weight}) that it can carry #{weight_limit}"
  end

  ##
  # Callback, put in before_update causes <tt>ActiveRecord::RecordNotSaved</tt>.
  #
  def check_on_update
    # TODO: Use a state machine instead of this callback
    abort_with_error(:state, 'Battery level to low for loading') if
      state_was != 'loading' && loading_state? && battery < 25 # TODO: Substitute with ENV var

    abort_with_error(:state, "Can't change state to loaded from #{state_was}") if
      state_was != 'loading' && loaded_state?

    abort_with_error(:state, "Can't change state to delivering from #{state_was}") if
      state_was != 'loaded' && delivering_state?

    if delivered_state? && active_cargo
      active_cargo.active = false
      active_cargo.save!
    end
  end
end
