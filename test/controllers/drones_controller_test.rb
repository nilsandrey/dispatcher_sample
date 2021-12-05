require 'test_helper'

class DronesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get drones_url
    assert_response :success
  end

  test 'should get create' do
    new_data = {"drone": {
      "serial_number": 'AABBCCDD6',
      "model": 'cruiserweight',
      "weight_limit": 520
    }}
    post drones_url, params: new_data
    assert_response :ok
  end

  test 'should get destroy' do
    delete drone_url(drones(:first_drone))
    assert_response :success
  end
end
