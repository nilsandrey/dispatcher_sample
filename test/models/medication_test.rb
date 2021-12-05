require "test_helper"

class MedicationTest < ActiveSupport::TestCase
  test "should not create medication without name, code, or weight" do
    medication = Medication.new
    assert_not(medication.save)
    assert_equal(true, medication.errors.messages.include?(:name))
    assert_equal(true, medication.errors.messages.include?(:code))
  end

  # Name should contain only letters, numbers, spaces, -, and _
  test "should not create medication with invalid name" do
    medication = Medication.new(name: '****', code: "12345", weight: "1")
    assert_not(medication.save)
    assert_equal(true, medication.errors.messages.include?(:name))
  end
end
