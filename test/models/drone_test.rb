require 'test_helper'

class DroneTest < ActiveSupport::TestCase
  test "Shouldn't allow long serial numbers" do
    d = drones(:first_drone)
    d.serial_number = random_string(101)
    assert_not d.valid?
  end

  test 'Should allow serial numbers til 100 chars' do
    1.upto(100) do |i|
      d = drones(:first_drone)
      d.serial_number = random_string(i)
      assert d.valid?, "Couldn't add #{d.serial_number}"
    end
  end

  test 'Should not allow duplicate serial numbers' do
    d = drones(:first_drone)
    d.serial_number = drones(:second_drone).serial_number
    assert_not d.valid?
  end
end
