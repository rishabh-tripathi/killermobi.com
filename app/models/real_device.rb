class RealDevice < ActiveRecord::Base

  APP_CODE_KILLERMOBI = 231923231919

  APP_USER_LOGGED_IN = 10
  APP_USER_ACCESS_TOKEN_REQUIRED = 5
  APP_USER_LOGOUT = -10

  LOGGED_OUT_SUCCESSFUL = 10
  LOGGED_OUT_UNSUCCESSFUL = -10


  def self.create_device(id, name, device_id, token)
    device = RealDevice.new
    device.user_id = id
    device.name = name
    device.virtual_device = device_id
    device.access_token = token
    device.save
    return device
  end

  def get_access_code

  end

  def self.search_by_authentication_token(token)
    device = RealDevice.find_by_authentication_tokens(token)
    return device
  end

  def self.search_by_access_code(token)
    device = RealDevice.find_by_access_token(token)
    return device
  end

end
