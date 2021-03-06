class Thermostat

  def initialize(data)
    @power_status = data[0]
    @heating_info = data[1]
    @user_location = data[2]
  end

  def is_powered
    @power_status[:powered]
  end

  def is_heating
    if @user_location[:home] == true
      @heating_info[:current_temp] < @heating_info[:requested_temp_home] ? true : false
    elsif @user_location[:home] == false && @user_location[:within_range] == true
      @heating_info[:current_temp] < @heating_info[:requested_temp_home] ? true : false
    else
      @heating_info[:current_temp] < @heating_info[:requested_temp_out] ? true : false
    end
  end



end
