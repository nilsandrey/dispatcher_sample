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
    cargos.active.first
  end

  ##
  # Add to the active cargo the specified count of the specified medication. If the cargo is
  # not created (idle drone), then create it and add this as the first item.
  #
  # @param [Hash] medication with this form <tt>{ 'medication': 'DDDFDFSDF', 'count': 2 }</tt>.
  # @raise <tt>:abort</tt> on invalid state.
  # @raise <tt>ActiveRecord::RecordNotSaved</tt> on invalid parameters.
  #
  def load(medication_code, count)
    return initialize_cargoes(medication_code, count) if idle_state?
    return continue_cargoes(medication_code, count) if loading_state?

    throw_error("Drone can't load cargo while in state #{state}")
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

  def add_supply(cargo, medication, count)
    supply = cargo.supplies.new
    supply.medication = medication_obj
    supply.count = count
    supply.save
    cargo.save
  end

  ##
  # Create a new <tt>Cargo</tt> to set as the active for this drone.
  # @param [Hash] medication with this form <tt>{ 'medication': 'DDDFDFSDF', 'count': 2 }</tt>.
  #
  def initialize_cargoes(medication_code, count)
    throw_error('Wrong call to initialize cargos; there\'s one active.') if active_cargo

    loading_state!
    medication_obj = locate_medication_or_abort(medication_code)
    add_supply(cargos.new, medication_obj, count)
  end

  ##
  # Continue adding supplies to the current <tt>active_cargo</tt>.
  #
  def continue_cargoes(medication_code, count)
    medication_obj = locate_medication_or_abort(medication_code)
    add_supply(active_cargo, medication_obj, count)
  end

  ##
  # Try to location medication defined by code. Call <tt>abort_with_error</tt> if not.
  #
  # @param [String] code Should match one <tt>Medication.code</tt>.
  # @return [Medication]
  #
  def locate_medication_or_abort(code)
    medication = Medication.find_by_code(code)
    throw_error("Medication with id `#{code}` not found") unless medication
    medication
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
    end
  end
end
