class VirtualDevice < ActiveRecord::Base

  def self.create_device(id, name)
    ud = UserDetail.find_by_user_id(id)
    device = VirtualDevice.new
    device.user_id = id
    device.name = name
    device.save
    ud.update_attribute(:virtual_device, device.id)
    return device
  end
end
