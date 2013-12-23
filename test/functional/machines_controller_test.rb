require 'test_helper'

class MachinesControllerTest < ActionController::TestCase
  setup do
    @machine = machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create machine" do
    assert_difference('Machine.count') do
      post :create, machine: { activated_on: @machine.activated_on, firmware_version: @machine.firmware_version, hw_config: @machine.hw_config, ip_address: @machine.ip_address, mac_address: @machine.mac_address, serial_number: @machine.serial_number, status: @machine.status }
    end

    assert_redirected_to machine_path(assigns(:machine))
  end

  test "should show machine" do
    get :show, id: @machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @machine
    assert_response :success
  end

  test "should update machine" do
    put :update, id: @machine, machine: { activated_on: @machine.activated_on, firmware_version: @machine.firmware_version, hw_config: @machine.hw_config, ip_address: @machine.ip_address, mac_address: @machine.mac_address, serial_number: @machine.serial_number, status: @machine.status }
    assert_redirected_to machine_path(assigns(:machine))
  end

  test "should destroy machine" do
    assert_difference('Machine.count', -1) do
      delete :destroy, id: @machine
    end

    assert_redirected_to machines_path
  end
end
