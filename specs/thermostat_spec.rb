require('minitest/autorun')
require('minitest/reporters')

require_relative('../thermostat.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestThermostat < MiniTest::Test

  def setup
    @power_status = {
      powered: true,
    }

    @heating_info = {
      current_temp: 16,
      requested_temp_home: 21,
      requested_temp_out: 15
    }

    @user_status = {
      home: true,
      within_range: false
    }

    @data = [@power_status, @heating_info, @user_status]

  end

  def test_is_powered
    heating_control = Thermostat.new(@data)
    assert_equal(true, heating_control.is_powered)
  end

  def test_is_heating_user_home__is_heating
    heating_control = Thermostat.new(@data)
    assert_equal(true, heating_control.is_heating)
  end

  def test_is_heating_user_home__is_not_heating
    heating_control = Thermostat.new(@data)
    @heating_info[:current_temp] = 23
    assert_equal(false, heating_control.is_heating)
  end

  def test_is_heating_user_not_home__is_heating
    @user_status[:home] = false
    heating_control = Thermostat.new(@data)
    @heating_info[:current_temp] = 13
    assert_equal(true, heating_control.is_heating)
  end

  def test_is_heating_user_not_home__is_not_heating
    @user_status[:home] = false
    heating_control = Thermostat.new(@data)
    @heating_info[:current_temp] = 18
    assert_equal(false, heating_control.is_heating)
  end

  def test_is_heating_user_heading_home__true
    @user_status[:home] = false
    @user_status[:within_range] = true
    heating_control = Thermostat.new(@data)
    @heating_info[:current_temp] = 18
    assert_equal(true, heating_control.is_heating)
  end

  def test_is_heating_user_heading_home__false
    @user_status[:home] = false
    heating_control = Thermostat.new(@data)
    @heating_info[:current_temp] = 18
    assert_equal(false, heating_control.is_heating)
  end

end
